---
name: power-bi
description: Power BI specialist covering data modeling (star schema), DAX measures, Power Query (M), report design, and performance optimization. Use when building Power BI dashboards, writing DAX, or troubleshooting Power BI models.
---

# Power BI

## Skill Stack

- `data-visualization` — chart selection and visual design principles
- `sql-analytics` — when data comes from SQL before entering Power BI
- `data-analytics` — for the business analysis that feeds into dashboards

## Guardrails

- Always use star schema — never import flat tables directly into the model
- Always create measures using CALCULATE — never use implicit measures from dragging fields
- Calculated columns consume RAM and slow refresh — prefer measures unless dimension lookup is needed
- Never use SUMX where SUM works — SUMX iterates row by row
- Bidirectional relationships break almost everything — use them only when you know why
- Report pages must have a single clear question they answer — not a dumping ground of charts

---

## Operating Modes

### Mode 1: Data Model Design

**Star schema — always:**
```
                    Dim_Date
                    ─────────
                    DateKey (PK)
                    Date
                    Year / Month / Quarter
                    WeekNum / DayName
                    IsWeekend / IsHoliday
                         │
Dim_Customer ────── Fact_Sales ────── Dim_Product
─────────────       ──────────        ───────────
CustomerKey (PK) →  DateKey (FK)   →  ProductKey (PK)
CustomerID          CustomerKey (FK)   ProductID
Name                ProductKey (FK)    Name
Segment             SalesRepKey (FK)   Category
Region              OrderID            Price
JoinDate            Quantity           COGS
                    Amount             Brand
                    Discount
                    Channel
                         │
                    Dim_SalesRep
                    ────────────
                    SalesRepKey (PK)
                    Name / Region / Team
```

**Relationship settings:**
- Cardinality: Many-to-One (fact → dimension) for all standard relationships
- Cross filter direction: **Single** (from dimension to fact) — bidirectional only for M2M via bridge table
- Active: one active relationship per pair — use USERELATIONSHIP() in DAX for inactive ones

**Date table — always create a dedicated one:**
```m
// Power Query: generate date table
let
    StartDate = #date(2020, 1, 1),
    EndDate = Date.From(DateTime.LocalNow()),
    Duration = Duration.Days(EndDate - StartDate) + 1,
    Dates = List.Dates(StartDate, Duration, #duration(1, 0, 0, 0)),
    Table = Table.FromList(Dates, Splitter.SplitByNothing(), {"Date"}),
    Types = Table.TransformColumnTypes(Table, {{"Date", type date}}),
    Year   = Table.AddColumn(Types,   "Year",      each Date.Year([Date]),            Int64.Type),
    Month  = Table.AddColumn(Year,    "MonthNum",  each Date.Month([Date]),           Int64.Type),
    MonthN = Table.AddColumn(Month,   "MonthName", each Date.ToText([Date], "MMM"),   type text),
    Qtr    = Table.AddColumn(MonthN,  "Quarter",   each "Q" & Text.From(Date.QuarterOfYear([Date])), type text),
    Week   = Table.AddColumn(Qtr,     "WeekNum",   each Date.WeekOfYear([Date]),      Int64.Type),
    Day    = Table.AddColumn(Week,    "DayName",   each Date.ToText([Date], "ddd"),   type text),
    IsWknd = Table.AddColumn(Day,     "IsWeekend", each Date.DayOfWeek([Date]) >= 5, type logical)
in IsWknd
```

Mark as Date Table: right-click → Mark as Date Table → select [Date] column.

---

### Mode 2: DAX Patterns Library

**The golden rule:** every measure is a CALCULATE expression, even if implicit.

```dax
// ═══════════════════════════════════════════════
// BASIC AGGREGATIONS
// ═══════════════════════════════════════════════

Total Revenue = SUM(Fact_Sales[Amount])

Total Orders = COUNTROWS(Fact_Sales)

Avg Order Value = DIVIDE([Total Revenue], [Total Orders], 0)

Gross Margin = DIVIDE(SUM(Fact_Sales[Amount]) - SUM(Fact_Sales[COGS]), SUM(Fact_Sales[Amount]), 0)

Distinct Customers = DISTINCTCOUNT(Fact_Sales[CustomerKey])


// ═══════════════════════════════════════════════
// FILTER CONTEXT MANIPULATION
// ═══════════════════════════════════════════════

// CALCULATE: changes the filter context
Revenue - Enterprise Only =
CALCULATE([Total Revenue], Dim_Customer[Segment] = "Enterprise")

// ALL: removes a filter (used for % of total)
Revenue % of Total =
DIVIDE([Total Revenue], CALCULATE([Total Revenue], ALL(Dim_Product)), 0)

// ALLEXCEPT: remove all filters except specified columns
Revenue % of Region =
DIVIDE(
    [Total Revenue],
    CALCULATE([Total Revenue], ALLEXCEPT(Dim_Customer, Dim_Customer[Region])),
    0
)

// FILTER: complex conditions in CALCULATE
Revenue - High Value Orders =
CALCULATE(
    [Total Revenue],
    FILTER(Fact_Sales, Fact_Sales[Amount] > 1000000)
)

// REMOVEFILTERS: remove specific column filters
Benchmark Revenue =
CALCULATE([Total Revenue], REMOVEFILTERS(Dim_Date[Month]))


// ═══════════════════════════════════════════════
// TIME INTELLIGENCE — requires marked Date Table
// ═══════════════════════════════════════════════

Revenue MTD  = TOTALMTD([Total Revenue], Dim_Date[Date])
Revenue QTD  = TOTALQTD([Total Revenue], Dim_Date[Date])
Revenue YTD  = TOTALYTD([Total Revenue], Dim_Date[Date])

Revenue SPLY = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(Dim_Date[Date]))
Revenue SPLM = CALCULATE([Total Revenue], DATEADD(Dim_Date[Date], -1, MONTH))

Revenue YoY Growth =
DIVIDE([Total Revenue] - [Revenue SPLY], ABS([Revenue SPLY]), BLANK())

Revenue MoM Growth =
DIVIDE([Total Revenue] - [Revenue SPLM], ABS([Revenue SPLM]), BLANK())

// Running total (different from YTD — not reset each year)
Revenue Running Total =
CALCULATE(
    [Total Revenue],
    FILTER(ALL(Dim_Date), Dim_Date[Date] <= MAX(Dim_Date[Date]))
)

// Moving average — 3 month
Revenue 3M Rolling Avg =
AVERAGEX(
    DATESINPERIOD(Dim_Date[Date], LASTDATE(Dim_Date[Date]), -3, MONTH),
    [Total Revenue]
)


// ═══════════════════════════════════════════════
// RANKING
// ═══════════════════════════════════════════════

Product Revenue Rank =
RANKX(ALL(Dim_Product[Name]), [Total Revenue], , DESC, DENSE)

// Top N filter — use in visual-level filter or with this pattern:
Is Top 10 Product =
IF([Product Revenue Rank] <= 10, 1, 0)

// Cumulative % (for Pareto chart)
Cumulative Revenue % =
DIVIDE(
    CALCULATE(
        [Total Revenue],
        FILTER(
            ALL(Dim_Product),
            [Product Revenue Rank] <= CALCULATE(MAX([Product Revenue Rank]))
        )
    ),
    CALCULATE([Total Revenue], ALL(Dim_Product)),
    0
)


// ═══════════════════════════════════════════════
// CONDITIONAL & DYNAMIC MEASURES
// ═══════════════════════════════════════════════

// Show BLANK when no selection (prevents misleading charts)
Revenue (Single Product) =
IF(HASONEVALUE(Dim_Product[Name]), [Total Revenue], BLANK())

// Dynamic measure based on slicer
Selected Metric =
SWITCH(
    SELECTEDVALUE(Slicer_Metric[Metric]),
    "Revenue",    [Total Revenue],
    "Orders",     [Total Orders],
    "Customers",  [Distinct Customers],
    [Total Revenue]  -- default
)

// What-if parameter (create via Modeling → New Parameter)
Revenue Forecast =
[Total Revenue] * (1 + [Growth Rate Value])


// ═══════════════════════════════════════════════
// CUSTOMER ANALYTICS
// ═══════════════════════════════════════════════

// Churn: customers active last period but not this period
Churned Customers =
VAR ActiveLastMonth =
    CALCULATETABLE(
        VALUES(Fact_Sales[CustomerKey]),
        DATEADD(Dim_Date[Date], -1, MONTH)
    )
VAR ActiveThisMonth =
    CALCULATETABLE(VALUES(Fact_Sales[CustomerKey]))
RETURN
    COUNTROWS(EXCEPT(ActiveLastMonth, ActiveThisMonth))

// New vs. returning customers
New Customers =
CALCULATE(
    [Distinct Customers],
    FILTER(
        VALUES(Dim_Customer[CustomerKey]),
        CALCULATE(MIN(Fact_Sales[OrderDate])) >= MIN(Dim_Date[Date])
    )
)

Returning Customers = [Distinct Customers] - [New Customers]
```

---

### Mode 3: Power Query (M) Patterns

```m
// ═══════════════════════════════════════════════
// COMMON TRANSFORMATIONS
// ═══════════════════════════════════════════════

// Full ETL pattern
let
    // 1. Source
    Source = Sql.Database("server", "database", [Query = "SELECT * FROM orders"]),

    // 2. Type enforcement (always do this early)
    Typed = Table.TransformColumnTypes(Source, {
        {"order_date", type date},
        {"amount", type number},
        {"customer_id", Int64.Type},
        {"status", type text}
    }),

    // 3. Filter out bad rows
    Filtered = Table.SelectRows(Typed, each
        [amount] <> null and [amount] >= 0 and
        [status] <> "test"
    ),

    // 4. Add calculated columns
    With_YearMonth = Table.AddColumn(Filtered, "YearMonth",
        each Date.Year([order_date]) * 100 + Date.Month([order_date]),
        Int64.Type
    ),
    With_Quarter = Table.AddColumn(With_YearMonth, "Quarter",
        each "Q" & Text.From(Date.QuarterOfYear([order_date])),
        type text
    ),

    // 5. Rename to standard names
    Renamed = Table.RenameColumns(With_Quarter, {
        {"order_date", "OrderDate"},
        {"customer_id", "CustomerID"},
        {"amount", "Amount"}
    }),

    // 6. Remove columns not needed in model
    Final = Table.RemoveColumns(Renamed, {"internal_flag", "legacy_id"})
in
    Final

// ─────────────────────────────────────────
// UNPIVOT (wide → long, for month columns)
// ─────────────────────────────────────────
let
    Source = ...,
    Unpivoted = Table.UnpivotOtherColumns(Source,
        {"Product", "Category"},    -- columns to keep as-is
        "Month",                    -- new attribute column name
        "Revenue"                   -- new value column name
    )
in Unpivoted

// ─────────────────────────────────────────
// MERGE (JOIN) two queries
// ─────────────────────────────────────────
let
    Orders = ...,
    Customers = ...,
    Merged = Table.NestedJoin(
        Orders, {"CustomerID"},
        Customers, {"ID"},
        "CustomerData",
        JoinKind.LeftOuter
    ),
    Expanded = Table.ExpandTableColumn(
        Merged, "CustomerData",
        {"Name", "Segment", "Region"}
    )
in Expanded

// ─────────────────────────────────────────
// PARAMETERIZE the source (dynamic connections)
// ─────────────────────────────────────────
// Create parameter: Manage Parameters → New → Name: StartDate, Type: Date
let
    FilteredDate = Table.SelectRows(Source, each [OrderDate] >= StartDate)
in FilteredDate
```

---

### Mode 4: Report Design Best Practices

**Page structure:**
- Page title = the business question this page answers
- Maximum 5-7 visuals per page
- KPI cards top row — most important numbers first
- Primary chart (biggest) top-left of content area
- Slicers on left side panel or top bar, consistent across pages

**Visual selection in Power BI:**
| Business question | Best visual |
|---|---|
| Trend over time | Line chart or Area chart |
| Comparison across categories | Bar / Column chart (sorted) |
| Part of whole (3-5 items) | Donut chart |
| Geographic distribution | Map / Filled map |
| Performance vs. target | KPI visual or Gauge |
| Correlation | Scatter chart |
| Ranking table | Matrix with conditional formatting |
| Drill-down hierarchy | Treemap or Decomposition tree |

**Conditional formatting in Matrix:**
- Background color scale: green (high) → red (low) for revenue metrics
- Icon sets: ▲▼→ for trend direction
- Data bars: for quick visual comparison in tables
- Never use conditional formatting on every column — pick max 2

**Performance optimization:**
- Disable cross-highlighting if not needed (Format → Edit interactions)
- Use Aggregations for large tables (>10M rows)
- Disable Auto Date/Time (File → Options → Data Load → uncheck)
- Remove unused columns and rows before loading into model
- Use DirectQuery for near-real-time; Import for speed

---

### Mode 5: Calculated Columns vs. Measures

```
Rule: measures > calculated columns, always.

Use calculated column ONLY when:
✓ You need a value to use as a slicer/filter
✓ You need a value in a relationship
✓ You need to concatenate row-level text

Use measure for EVERYTHING else:
✓ Aggregations (SUM, COUNT, AVG)
✓ Ratios and percentages
✓ Time intelligence
✓ Ranking
✓ Conditional logic on aggregated data
```

```dax
// BAD: Calculated column (executes on every row, stored in RAM)
Revenue Category (Column) =
IF(Fact_Sales[Amount] > 1000000, "High", "Low")  // ← calculated column

// GOOD: Measure (executes only when visual is rendered)
Revenue Category KPI =
IF([Total Revenue] > 1000000, "High", "Low")      // ← measure
```

---

## Quality Gate

Before publishing a Power BI report:
- [ ] Data model is star schema — no flat tables, no snowflake unless necessary
- [ ] Date table created and marked as Date Table
- [ ] All relationships are Many-to-One with Single cross-filter direction
- [ ] All measures use CALCULATE and are in a dedicated Measures table
- [ ] No calculated columns where a measure would work
- [ ] Report page titles state the business question, not just the subject
- [ ] All visuals have consistent formatting (colors, font size, title format)
- [ ] Data refresh configured and tested
- [ ] Row-level security (RLS) set if data is sensitive
