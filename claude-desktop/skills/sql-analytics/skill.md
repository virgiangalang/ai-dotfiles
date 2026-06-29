---
name: sql-analytics
description: Analytical SQL specialist covering window functions, CTEs, cohort analysis, funnel queries, dbt modeling, and performance optimization for BigQuery, Snowflake, PostgreSQL, and MySQL. Use when the task is writing or optimizing SQL for analytics, reporting, or data transformation.
---

# SQL Analytics

## Skill Stack

- `data-analytics` — after querying, feed results into business analysis
- `data-visualization` — query output feeds charts and dashboards
- `power-bi` — when queries power a Power BI semantic model
- `database-reviewer` — for schema design and index strategy

## Guardrails

- Never use `SELECT *` in production queries — always name columns explicitly
- Never run a DELETE or UPDATE without a SELECT first to verify what's affected
- Always test aggregations on a sample before running on full table
- Never use subqueries where a CTE makes it readable — readability > micro-optimization
- Always specify JOIN type explicitly (INNER, LEFT, etc.) — implicit joins hide bugs
- For large tables: always check query cost estimate before running (BigQuery: DRY RUN)

---

## Operating Modes

### Mode 1: Window Functions — the analytics superpower

Window functions do calculations across a set of rows related to the current row — without collapsing rows like GROUP BY does.

**Syntax anatomy:**
```sql
function_name() OVER (
    PARTITION BY column    -- group within each value of this column
    ORDER BY column        -- order within the window
    ROWS BETWEEN ...       -- optional: define the frame
)
```

**Ranking functions:**
```sql
-- ROW_NUMBER: unique rank, no ties
-- RANK: tied values get same rank, next rank skips (1,1,3)
-- DENSE_RANK: tied values get same rank, next rank doesn't skip (1,1,2)

SELECT
    customer_id,
    order_amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS order_seq,
    RANK()       OVER (ORDER BY order_amount DESC) AS revenue_rank,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY order_amount DESC) AS regional_rank,
    NTILE(4)     OVER (ORDER BY order_amount DESC) AS quartile  -- splits into 4 buckets
FROM orders;

-- Get each customer's most recent order only
WITH ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
)
SELECT * FROM ranked WHERE rn = 1;
```

**Aggregate window functions:**
```sql
-- Running total, moving average, cumulative %
SELECT
    date,
    revenue,
    SUM(revenue)    OVER (ORDER BY date) AS running_total,
    AVG(revenue)    OVER (ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS revenue_7d_ma,
    MAX(revenue)    OVER (PARTITION BY EXTRACT(YEAR FROM date)) AS year_peak,
    revenue / SUM(revenue) OVER () * 100 AS pct_of_total,
    revenue / SUM(revenue) OVER (PARTITION BY channel) * 100 AS pct_of_channel
FROM daily_revenue;
```

**LAG / LEAD — period-over-period comparison:**
```sql
SELECT
    date,
    revenue,
    LAG(revenue, 1)  OVER (ORDER BY date) AS prev_day_revenue,
    LAG(revenue, 7)  OVER (ORDER BY date) AS prev_week_revenue,
    LEAD(revenue, 1) OVER (ORDER BY date) AS next_day_revenue,

    -- MoM Growth
    (revenue - LAG(revenue, 1) OVER (PARTITION BY channel ORDER BY month)) /
    NULLIF(LAG(revenue, 1) OVER (PARTITION BY channel ORDER BY month), 0) * 100
    AS mom_growth_pct
FROM daily_revenue;
```

**FIRST_VALUE / LAST_VALUE:**
```sql
SELECT
    customer_id,
    order_date,
    FIRST_VALUE(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS first_order_date,
    LAST_VALUE(order_date)  OVER (PARTITION BY customer_id ORDER BY order_date
                                  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_date
FROM orders;
```

---

### Mode 2: CTEs — Structure Complex Queries

Always use CTEs for multi-step logic. Never nest more than 2 subqueries — use a CTE instead.

```sql
-- Pattern: each CTE is one transformation step, named by its job
WITH
-- Step 1: Filter to relevant orders
valid_orders AS (
    SELECT *
    FROM orders
    WHERE status NOT IN ('cancelled', 'refunded')
      AND order_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '12 months')
),

-- Step 2: Aggregate by customer-month
customer_monthly AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        COUNT(*)           AS order_count,
        SUM(amount)        AS revenue,
        AVG(amount)        AS avg_order_value
    FROM valid_orders
    GROUP BY 1, 2
),

-- Step 3: Add customer metadata
enriched AS (
    SELECT
        cm.*,
        c.segment,
        c.acquisition_channel,
        c.signup_date
    FROM customer_monthly cm
    JOIN customers c ON cm.customer_id = c.id
),

-- Step 4: Calculate derived metrics
final AS (
    SELECT
        *,
        SUM(revenue) OVER (PARTITION BY customer_id ORDER BY order_month) AS cumulative_revenue,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_month) AS months_active
    FROM enriched
)

SELECT * FROM final
ORDER BY customer_id, order_month;
```

---

### Mode 3: Cohort Analysis

The gold standard for understanding retention and customer behavior over time.

```sql
-- Step 1: Assign each customer to their signup cohort (month)
WITH cohorts AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM orders
    GROUP BY customer_id
),

-- Step 2: For each customer, get all months they were active
customer_activity AS (
    SELECT
        o.customer_id,
        DATE_TRUNC('month', o.order_date) AS activity_month
    FROM orders o
    GROUP BY 1, 2
),

-- Step 3: Calculate how many months since signup
cohort_data AS (
    SELECT
        c.cohort_month,
        ca.activity_month,
        DATEDIFF('month', c.cohort_month, ca.activity_month) AS month_number,
        COUNT(DISTINCT ca.customer_id) AS customers
    FROM cohorts c
    JOIN customer_activity ca ON c.customer_id = ca.customer_id
    GROUP BY 1, 2, 3
),

-- Step 4: Get cohort size (month 0)
cohort_sizes AS (
    SELECT cohort_month, customers AS cohort_size
    FROM cohort_data
    WHERE month_number = 0
)

-- Step 5: Pivot into retention table
SELECT
    cd.cohort_month,
    cs.cohort_size,
    cd.month_number,
    cd.customers,
    ROUND(cd.customers * 100.0 / cs.cohort_size, 1) AS retention_pct
FROM cohort_data cd
JOIN cohort_sizes cs ON cd.cohort_month = cs.cohort_month
ORDER BY cd.cohort_month, cd.month_number;
```

---

### Mode 4: Funnel Analysis

```sql
-- Conversion funnel: track users through steps
WITH funnel_steps AS (
    SELECT
        user_id,
        MAX(CASE WHEN event_name = 'page_view'        THEN 1 ELSE 0 END) AS step_1,
        MAX(CASE WHEN event_name = 'add_to_cart'      THEN 1 ELSE 0 END) AS step_2,
        MAX(CASE WHEN event_name = 'checkout_started' THEN 1 ELSE 0 END) AS step_3,
        MAX(CASE WHEN event_name = 'purchase'         THEN 1 ELSE 0 END) AS step_4
    FROM events
    WHERE event_date >= CURRENT_DATE - 30
    GROUP BY user_id
)
SELECT
    SUM(step_1) AS visitors,
    SUM(step_2) AS added_to_cart,
    SUM(step_3) AS checkout_started,
    SUM(step_4) AS purchased,
    ROUND(SUM(step_2) * 100.0 / NULLIF(SUM(step_1), 0), 1) AS add_to_cart_rate,
    ROUND(SUM(step_3) * 100.0 / NULLIF(SUM(step_2), 0), 1) AS checkout_rate,
    ROUND(SUM(step_4) * 100.0 / NULLIF(SUM(step_3), 0), 1) AS purchase_rate,
    ROUND(SUM(step_4) * 100.0 / NULLIF(SUM(step_1), 0), 1) AS overall_conversion
FROM funnel_steps;
```

---

### Mode 5: dbt — Production Data Modeling

dbt (data build tool) transforms raw data in your warehouse using version-controlled SQL.

**Project structure:**
```
models/
├── staging/           # 1:1 with source tables, light transformations
│   ├── stg_orders.sql
│   └── stg_customers.sql
├── intermediate/      # business logic, joins
│   └── int_customer_orders.sql
└── marts/             # final tables consumed by BI tools
    ├── core/
    │   ├── dim_customers.sql
    │   └── fact_orders.sql
    └── marketing/
        └── mrt_campaign_performance.sql
```

**Staging model (stg_orders.sql):**
```sql
-- models/staging/stg_orders.sql
WITH source AS (
    SELECT * FROM {{ source('raw', 'orders') }}
),

renamed AS (
    SELECT
        id                                              AS order_id,
        customer_id,
        CAST(created_at AS TIMESTAMP)                  AS order_at,
        DATE_TRUNC('day', CAST(created_at AS DATE))    AS order_date,
        status,
        CAST(total_amount AS NUMERIC)                  AS order_amount,
        LOWER(TRIM(channel))                           AS channel
    FROM source
    WHERE id IS NOT NULL
)

SELECT * FROM renamed
```

**Mart model with refs:**
```sql
-- models/marts/core/fact_orders.sql
WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}   -- ref() creates dependency graph
),
customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
)
SELECT
    o.order_id,
    o.order_at,
    o.order_amount,
    c.customer_id,
    c.segment,
    c.acquisition_channel
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
```

**Schema.yml — define tests and documentation:**
```yaml
version: 2
models:
  - name: fact_orders
    description: "One row per order, joined with customer dimension"
    columns:
      - name: order_id
        description: "Primary key — unique per order"
        tests:
          - unique
          - not_null
      - name: order_amount
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
      - name: channel
        tests:
          - accepted_values:
              values: ['organic', 'paid', 'referral', 'direct']
```

**dbt commands:**
```bash
dbt run                          # run all models
dbt run --select fact_orders     # run specific model
dbt run --select +fact_orders    # run model + all upstream deps
dbt test                         # run all data quality tests
dbt build                        # run + test in one command
dbt docs generate && dbt docs serve   # auto-generate data catalog
dbt snapshot                     # capture slowly changing dimensions
```

---

### Mode 6: Query Performance Optimization

```sql
-- EXPLAIN ANALYZE to see query execution plan
EXPLAIN ANALYZE
SELECT customer_id, SUM(amount) FROM orders GROUP BY 1;

-- Common performance fixes:

-- 1. Filter early using subquery/CTE before joining
WITH recent_orders AS (
    SELECT * FROM orders WHERE order_date >= '2025-01-01'  -- filter first
)
SELECT c.name, SUM(o.amount)
FROM recent_orders o
JOIN customers c ON o.customer_id = c.id
GROUP BY 1;

-- 2. Use QUALIFY instead of subquery for window function filtering (BigQuery/Snowflake)
SELECT *
FROM orders
QUALIFY ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1;
-- vs. slow subquery:
-- SELECT * FROM (SELECT *, ROW_NUMBER() OVER (...) AS rn FROM orders) WHERE rn = 1

-- 3. Avoid functions on indexed columns in WHERE clause
-- Bad (prevents index use):
WHERE EXTRACT(YEAR FROM order_date) = 2025
-- Good:
WHERE order_date >= '2025-01-01' AND order_date < '2026-01-01'

-- 4. BigQuery: partition pruning
-- Always filter on partition column (usually date)
WHERE _PARTITIONDATE >= '2025-01-01'

-- 5. Snowflake: use SAMPLE for development
SELECT * FROM orders SAMPLE (1000 ROWS)  -- test on sample, run full on prod
```

---

## Quality Gate

Before shipping a SQL query or dbt model:
- [ ] No `SELECT *` in production queries
- [ ] JOINs explicitly typed (INNER / LEFT / etc.)
- [ ] All NULLs handled — `COALESCE()` or `NULLIF()` where needed
- [ ] Aggregations tested on sample data first
- [ ] Window function frame explicitly defined where default is wrong
- [ ] For dbt: schema.yml has unique + not_null tests on primary keys
- [ ] Query cost estimated before running on full table (BigQuery dry run)
- [ ] Result row count sanity-checked (unexpected explosion = wrong join)
