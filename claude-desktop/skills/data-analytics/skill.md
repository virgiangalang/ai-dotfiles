---
name: data-analytics
description: Business data analytics for founders, CEOs, and business owners. Analyzes CSV files, spreadsheets, database exports, and raw metrics to extract KPIs, trends, anomalies, and actionable insights. Outputs plain-English executive summaries, not raw charts. Works with Python/pandas when computation is needed. Use when you have data and need business decisions, not when you need a visualization library.
---

# Data Analytics

## Skill Stack

Pull these into the workflow when relevant:
- `python-patterns` — when computation requires pandas, numpy, or data manipulation code
- `database-migrations` or SQL patterns — when data needs to be queried from a source first
- `market-research` — when the analysis output should be benchmarked against industry data
- `stakeholder-comms` — when the output is a board/executive report rather than internal analysis
- `finance-billing-ops` — when analyzing revenue, billing, or pricing data specifically

## Guardrails

- Never fabricate numbers — if data is missing, say so and explain the impact
- Always state sample size, date range, and any data quality caveats before conclusions
- Distinguish: fact (from data), inference (from pattern), recommendation (from judgment)
- Don't present averages without distribution — averages hide everything that matters
- Don't conclude causation from correlation without flagging it explicitly
- When data is ambiguous, present the two interpretations and their implications

## When to Activate

- "Analyze this CSV for me"
- "What do my sales numbers tell me?"
- "Find the trend in this data"
- "Calculate my MRR / churn / CAC / LTV"
- "Something looks off in our numbers — help me investigate"
- "What should I focus on based on this data?"
- Any request involving data files, spreadsheets, or exported metrics

---

## Operating Modes

### Mode 1: CSV / Spreadsheet Analysis

**Step 1 — Understand the data before analyzing it**
```
Ask (or infer):
- What is this data about? (sales, users, transactions, support, etc.)
- What time period does it cover?
- What decision do you need to make from this data?
- Are there known data quality issues? (missing values, duplicates, etc.)
```

**Step 2 — Audit the data**
```python
import pandas as pd

df = pd.read_csv('data.csv')

print(df.shape)           # rows × columns
print(df.dtypes)          # column types — find miscoded dates, strings as numbers
print(df.isnull().sum())  # missing values per column
print(df.describe())      # statistical summary
print(df.head(10))        # sample — sanity check
```

Flag immediately: missing values >5% in key columns, obvious outliers, date parsing errors, duplicate rows.

**Step 3 — Compute metrics relevant to the business question**

See KPI library below.

**Step 4 — Deliver insight, not output**

Bad: "The average order value is Rp 85,000."
Good: "Average order value is Rp 85,000, but the median is Rp 45,000 — meaning a small number of high-value orders are pulling the average up. 60% of orders are under Rp 40,000. If you're planning pricing or upsell strategy around 'typical' customers, use Rp 40,000–45,000, not Rp 85,000."

---

### Mode 2: Business KPI Calculation Library

#### Revenue Metrics

```python
# MRR (Monthly Recurring Revenue)
mrr = df[df['type'] == 'subscription']['amount'].sum()

# ARR
arr = mrr * 12

# ARPU (Average Revenue Per User)
arpu = total_revenue / active_users

# Revenue Growth Rate (MoM)
growth = (this_month_revenue - last_month_revenue) / last_month_revenue * 100

# Net Revenue Retention (NRR)
# MRR from existing customers this month vs. same cohort last month
nrr = (mrr_existing - churn_mrr + expansion_mrr) / mrr_start * 100
# >100% = expansion > churn (very healthy)
```

#### Customer Metrics

```python
# Customer Acquisition Cost (CAC)
cac = total_sales_marketing_spend / new_customers_acquired

# Lifetime Value (LTV) — simple
ltv = arpu * avg_customer_lifetime_months

# LTV:CAC ratio — should be >3:1 for healthy SaaS
ltv_cac_ratio = ltv / cac

# Payback Period (months to recover CAC)
payback = cac / (arpu * gross_margin_rate)
# Target: <12 months for SaaS, <6 for high-velocity

# Churn Rate (monthly)
monthly_churn = customers_lost_this_month / customers_start_of_month * 100
# <2% monthly = good B2B SaaS; <5% monthly = acceptable

# Retention Rate
retention = 100 - monthly_churn

# DAU/MAU Ratio (engagement)
dau_mau = daily_active_users / monthly_active_users * 100
# >20% = strong engagement; >50% = exceptional
```

#### Cohort Analysis

```python
# Group users by signup month, track retention over time
df['cohort'] = pd.to_datetime(df['signup_date']).dt.to_period('M')
df['period'] = pd.to_datetime(df['active_date']).dt.to_period('M')
df['months_since_signup'] = (df['period'] - df['cohort']).apply(lambda x: x.n)

cohort_table = df.groupby(['cohort', 'months_since_signup'])['user_id'].nunique().unstack()
cohort_pct = cohort_table.divide(cohort_table[0], axis=0) * 100
```

What to look for: is retention improving across newer cohorts? Which month has the biggest drop-off?

#### Growth Metrics

```python
# Week-over-Week Growth
wow = (this_week - last_week) / last_week * 100

# Compound Monthly Growth Rate (CMGR)
import numpy as np
months = 6
cmgr = (final_value / initial_value) ** (1/months) - 1

# Rule of 40 (SaaS health: growth rate + profit margin ≥ 40%)
rule_of_40 = annual_growth_rate + ebitda_margin
# <20: concerning; 20-40: developing; >40: strong
```

#### Unit Economics Health Check

```python
health = {
    'LTV:CAC':      ltv / cac,              # target: >3
    'Payback (mo)': cac / (arpu * gm),      # target: <12
    'Gross Margin': gross_profit / revenue,  # target: >70% SaaS
    'Monthly Churn':churn_rate,              # target: <2% B2B
    'CAC Recovery': cac / arpu,             # months until customer pays back
}
for k, v in health.items():
    print(f"{k}: {v:.2f}")
```

---

### Mode 3: Trend & Anomaly Detection

**Trend analysis — what's the direction?**
```python
# Moving average to smooth noise
df['7d_ma'] = df['metric'].rolling(7).mean()
df['30d_ma'] = df['metric'].rolling(30).mean()

# Is the trend accelerating or decelerating?
# Look at the slope of the MA, not just the MA value
df['trend_slope'] = df['30d_ma'].diff()
```

**Anomaly detection — what's weird?**
```python
# Z-score: values >3 standard deviations are anomalies
from scipy import stats
df['zscore'] = np.abs(stats.zscore(df['metric'].dropna()))
anomalies = df[df['zscore'] > 3]
```

Always investigate anomalies before reporting them — they may be:
- Data errors (bad import, timezone issue, duplicates)
- Real events (promotion, outage, viral spike)
- Meaningful signals (new customer segment, feature adoption)

**Seasonality check:**
```python
# Group by day of week or month to find patterns
df['day_of_week'] = pd.to_datetime(df['date']).dt.day_name()
df.groupby('day_of_week')['metric'].mean().sort_values(ascending=False)
```

---

### Mode 4: Executive Summary Output

After analysis, always deliver in this structure:

```
DATA SUMMARY
Source: [file/table name] | Period: [date range] | Records: [N]
Data quality: [any caveats — missing values, estimated figures]

HEADLINE NUMBERS
• [Most important metric]: [value] ([trend ↑↓→ vs previous period])
• [Second most important]: [value] ([trend])
• [Third]: [value] ([trend])

KEY FINDINGS
1. [Finding] — What it means: [plain-language implication]
2. [Finding] — What it means: [plain-language implication]
3. [Finding] — What it means: [plain-language implication]

RED FLAGS (requires attention)
• [Metric or trend that is concerning and why]

OPPORTUNITIES (data-backed)
• [What the data suggests you should do, with reasoning]

WHAT TO WATCH NEXT
• [Metric to track] — why: [leading indicator for X]

RECOMMENDED ACTIONS
1. [Specific action] — rationale: [from data]
2. [Specific action] — rationale: [from data]
```

---

### Mode 5: Self-Serve Analytics Setup

When the user needs ongoing analytics (not one-time):

```python
# Template: weekly business report generator
import pandas as pd
from datetime import datetime, timedelta

def weekly_report(df, metric_col, date_col):
    today = datetime.now()
    week_ago = today - timedelta(days=7)
    
    this_week = df[df[date_col] >= week_ago][metric_col].sum()
    last_week = df[(df[date_col] >= week_ago - timedelta(days=7)) & 
                   (df[date_col] < week_ago)][metric_col].sum()
    
    wow_growth = (this_week - last_week) / last_week * 100
    
    return {
        'period': f"{week_ago.date()} to {today.date()}",
        'this_week': this_week,
        'last_week': last_week,
        'wow_growth': f"{wow_growth:.1f}%",
        'trend': '↑' if wow_growth > 0 else '↓'
    }
```

For ongoing tracking, pair with `data-scraper-agent` to automate data collection.

---

## Common Business Data Scenarios

| Data Type | Key Questions to Answer | Key Metrics |
|-----------|------------------------|-------------|
| Sales/Revenue CSV | What's growing? Where's the drop? | MRR, ARPU, growth rate |
| Customer CSV | Who are our best customers? Who's churning? | LTV, churn, cohort retention |
| Transaction log | What's the most common purchase? Peak times? | AOV, frequency, seasonality |
| Marketing data | Which channel brings best customers? | CAC by channel, LTV by acquisition |
| Product usage | Who's active? Who's not? | DAU/MAU, feature adoption, dormancy |
| Support tickets | What breaks most? What takes longest? | Volume by category, resolution time |
| Financial data | Are we healthy? Profitable? | Gross margin, burn rate, runway |

---

## Quality Gate

Before delivering analysis:
- [ ] Sample size stated — is N large enough to draw conclusions?
- [ ] Date range stated — is the period representative?
- [ ] Data quality caveats disclosed — missing data, estimated values
- [ ] Correlation vs. causation distinguished where applicable
- [ ] Recommendations are actionable — not "improve churn" but "investigate why Q2 cohort has 8% monthly churn vs. 2% for other cohorts"
- [ ] Numbers contextualized — a number without a benchmark is just a number
