---
name: data-visualization
description: Data visualization specialist covering chart selection, Python (matplotlib/seaborn/plotly), Power BI, Tableau, and dashboard design principles. Produces publication-quality charts and executive dashboards. Use when the task is visualization, not raw analysis.
---

# Data Visualization

## Skill Stack

- `data-analytics` — run analysis first; visualization communicates results, not raw data
- `power-bi` — when output target is a Power BI dashboard
- `sql-analytics` — when data needs querying before visualizing
- `stakeholder-comms` — when the chart is going into a board or investor deck

## Guardrails

- Never use a pie chart with more than 5 slices — use a bar chart instead
- Never use 3D charts — they distort perception and add zero information
- Never show a trend line without showing the data points (or confidence interval)
- Always label axes with units — "Revenue" is wrong, "Revenue (IDR millions)" is right
- Never default to Excel defaults (rainbow colors, gridlines, bold borders) — they are actively bad
- Color is for encoding meaning, not decoration — one insight = one color highlight

---

## Chart Selection Framework

Pick the chart based on what you're trying to show:

| What you're showing | Best chart | Avoid |
|---|---|---|
| Comparison (few items) | Bar chart (horizontal) | Pie chart |
| Comparison (many items) | Dot plot / lollipop | Stacked bar |
| Trend over time | Line chart | Bar chart |
| Composition (parts of whole) | Stacked area / treemap | Pie chart |
| Distribution | Histogram / box plot / violin | Line chart |
| Correlation | Scatter plot | Bar chart |
| Ranking | Horizontal bar (sorted) | Vertical bar |
| Geographic | Choropleth / bubble map | 3D map |
| Part-to-whole (≤5 parts) | Waffle chart / pie | 3D donut |
| Deviation from baseline | Diverging bar | Regular bar |

**The one question that picks your chart:** *"Am I comparing, trending, distributing, relating, or compositing?"*

---

## Operating Modes

### Mode 1: Python — matplotlib / seaborn

**Setup (always use this template):**
```python
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np

# Professional style defaults
plt.rcParams.update({
    'figure.figsize': (10, 6),
    'axes.spines.top': False,
    'axes.spines.right': False,
    'axes.grid': True,
    'grid.alpha': 0.3,
    'font.family': 'sans-serif',
    'axes.labelsize': 12,
    'axes.titlesize': 14,
    'axes.titleweight': 'bold',
})
COLORS = ['#2563EB', '#DC2626', '#16A34A', '#D97706', '#7C3AED']
```

**Bar chart (horizontal — always prefer this for comparisons):**
```python
fig, ax = plt.subplots(figsize=(10, 6))
df_sorted = df.sort_values('value', ascending=True)  # ascending=True for horizontal

bars = ax.barh(df_sorted['category'], df_sorted['value'],
               color=COLORS[0], alpha=0.85)

# Add value labels
for bar, val in zip(bars, df_sorted['value']):
    ax.text(bar.get_width() + max(df_sorted['value'])*0.01,
            bar.get_y() + bar.get_height()/2,
            f'{val:,.0f}', va='center', fontsize=10)

ax.set_xlabel('Revenue (IDR millions)')
ax.set_title('Revenue by Channel — Q2 2025', pad=15)
ax.spines['left'].set_visible(False)
ax.tick_params(left=False)
plt.tight_layout()
plt.savefig('chart.png', dpi=150, bbox_inches='tight')
```

**Line chart (time series with multiple series):**
```python
fig, ax = plt.subplots(figsize=(12, 5))

for i, (col, label) in enumerate(series_map.items()):
    ax.plot(df['date'], df[col], color=COLORS[i], linewidth=2.5,
            label=label, marker='o', markersize=4)

# Highlight a specific event
ax.axvline(pd.Timestamp('2025-03-01'), color='gray', linestyle='--',
           alpha=0.6, label='Product Launch')

ax.legend(frameon=False, loc='upper left')
ax.set_ylabel('Users (thousands)')
ax.set_title('Daily Active Users — Jan to Jun 2025', pad=15)

# Format x-axis dates
import matplotlib.dates as mdates
ax.xaxis.set_major_formatter(mdates.DateFormatter('%b %Y'))
ax.xaxis.set_major_locator(mdates.MonthLocator())
plt.xticks(rotation=30)
plt.tight_layout()
```

**Distribution — histogram with KDE:**
```python
fig, ax = plt.subplots(figsize=(10, 5))

ax.hist(df['value'], bins=30, color=COLORS[0], alpha=0.6,
        edgecolor='white', density=True, label='Distribution')

# Overlay KDE
from scipy.stats import gaussian_kde
kde = gaussian_kde(df['value'].dropna())
x_range = np.linspace(df['value'].min(), df['value'].max(), 200)
ax.plot(x_range, kde(x_range), color=COLORS[0], linewidth=2.5, label='KDE')

# Add percentile lines
p50 = df['value'].quantile(0.5)
p90 = df['value'].quantile(0.9)
ax.axvline(p50, color=COLORS[1], linestyle='--', label=f'Median: {p50:,.0f}')
ax.axvline(p90, color=COLORS[2], linestyle='--', label=f'P90: {p90:,.0f}')

ax.set_xlabel('Order Value (IDR)')
ax.set_title('Order Value Distribution', pad=15)
ax.legend(frameon=False)
plt.tight_layout()
```

**Heatmap (correlation or time-based patterns):**
```python
fig, ax = plt.subplots(figsize=(10, 8))

# Correlation heatmap
corr = df[numeric_cols].corr()
mask = np.triu(np.ones_like(corr, dtype=bool))  # hide upper triangle

sns.heatmap(corr, mask=mask, annot=True, fmt='.2f', cmap='RdYlGn',
            center=0, vmin=-1, vmax=1, ax=ax,
            linewidths=0.5, cbar_kws={'shrink': 0.8})

ax.set_title('Correlation Matrix', pad=15)
plt.tight_layout()
```

---

### Mode 2: Python — Plotly (interactive)

Use Plotly when the output is a web app, Streamlit, or Jupyter notebook where interactivity adds value.

```python
import plotly.express as px
import plotly.graph_objects as go

# Color palette consistent with brand
PLOTLY_COLORS = ['#2563EB', '#DC2626', '#16A34A', '#D97706']

# Bar chart
fig = px.bar(df, x='category', y='value', color='segment',
             color_discrete_sequence=PLOTLY_COLORS,
             title='Revenue by Category and Segment',
             labels={'value': 'Revenue (IDR M)', 'category': ''})

fig.update_layout(
    plot_bgcolor='white',
    paper_bgcolor='white',
    font=dict(family='sans-serif', size=12),
    legend=dict(orientation='h', yanchor='bottom', y=1.02),
    showlegend=True,
)
fig.update_xaxes(showgrid=False)
fig.update_yaxes(gridcolor='#f0f0f0', gridwidth=1)

fig.show()
fig.write_html('chart.html')

# Funnel chart (great for conversion funnels)
fig = go.Figure(go.Funnel(
    y=['Visitors', 'Leads', 'MQL', 'SQL', 'Customers'],
    x=[100000, 8000, 2400, 960, 192],
    textinfo='value+percent initial',
    marker=dict(color=PLOTLY_COLORS),
))
fig.update_layout(title='Conversion Funnel — Q2 2025')

# Scatter with trend line
fig = px.scatter(df, x='cac', y='ltv', color='channel', size='revenue',
                 trendline='ols',
                 title='LTV vs CAC by Acquisition Channel',
                 labels={'cac': 'Customer Acquisition Cost (IDR)', 'ltv': 'LTV (IDR)'})
```

**Streamlit dashboard template:**
```python
import streamlit as st
import plotly.express as px
import pandas as pd

st.set_page_config(page_title='Business Dashboard', layout='wide')
st.title('Business Analytics Dashboard')

# Sidebar filters
with st.sidebar:
    date_range = st.date_input('Date Range', [df['date'].min(), df['date'].max()])
    channels = st.multiselect('Channels', df['channel'].unique(), default=df['channel'].unique())

# Filter data
filtered = df[(df['date'] >= pd.Timestamp(date_range[0])) &
              (df['date'] <= pd.Timestamp(date_range[1])) &
              (df['channel'].isin(channels))]

# KPI cards
col1, col2, col3, col4 = st.columns(4)
with col1: st.metric('Total Revenue', f"Rp {filtered['revenue'].sum()/1e6:.1f}M", delta='↑12%')
with col2: st.metric('New Customers', f"{filtered['customers'].sum():,}", delta='↑8%')
with col3: st.metric('Avg Order Value', f"Rp {filtered['aov'].mean():,.0f}", delta='↑3%')
with col4: st.metric('Churn Rate', f"{filtered['churn'].mean():.1%}", delta='-0.3%', delta_color='inverse')

# Charts
col1, col2 = st.columns(2)
with col1:
    fig = px.line(filtered, x='date', y='revenue', color='channel', title='Revenue Trend')
    st.plotly_chart(fig, use_container_width=True)
with col2:
    fig = px.bar(filtered.groupby('channel')['revenue'].sum().reset_index(),
                 x='channel', y='revenue', title='Revenue by Channel')
    st.plotly_chart(fig, use_container_width=True)
```

---

### Mode 3: Power BI — Design Patterns

**Data model (always star schema — never flat table):**
```
Fact_Sales          Dim_Date          Dim_Customer      Dim_Product
──────────          ────────          ────────────      ───────────
OrderID         →   DateKey           CustomerKey   →   ProductKey
DateKey             Date              CustomerID        ProductID
CustomerKey         Year              Name              Name
ProductKey          Month             Segment           Category
Amount              Quarter           Region            Price
Quantity            DayOfWeek         JoinDate          COGS
```

**DAX — essential patterns:**
```dax
-- Basic measure (always use CALCULATE, not raw SUM)
Total Revenue = CALCULATE(SUM(Fact_Sales[Amount]))

-- Time intelligence: Month-over-Month growth
Revenue MoM Growth =
VAR ThisMonth = [Total Revenue]
VAR LastMonth = CALCULATE([Total Revenue], DATEADD(Dim_Date[Date], -1, MONTH))
RETURN DIVIDE(ThisMonth - LastMonth, LastMonth, 0)

-- Running total (year-to-date)
Revenue YTD = CALCULATE([Total Revenue], DATESYTD(Dim_Date[Date]))

-- Same period last year
Revenue SPLY = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(Dim_Date[Date]))

-- Customer count (distinct)
Active Customers = DISTINCTCOUNT(Fact_Sales[CustomerKey])

-- Conditional measure: show only if selection is valid
Revenue (Selected) =
IF(HASONEVALUE(Dim_Customer[Segment]), [Total Revenue], BLANK())

-- Ranking
Product Rank =
RANKX(ALL(Dim_Product[Name]), [Total Revenue], , DESC, DENSE)

-- Moving average (7-day)
Revenue 7D MA =
AVERAGEX(
    DATESINPERIOD(Dim_Date[Date], LASTDATE(Dim_Date[Date]), -7, DAY),
    [Total Revenue]
)

-- Pareto (cumulative % — for 80/20 analysis)
Cumulative % =
DIVIDE(
    CALCULATE([Total Revenue], FILTER(ALL(Dim_Product), [Product Rank] <= MAX([Product Rank]))),
    CALCULATE([Total Revenue], ALL(Dim_Product))
)
```

**Power Query (M) — common transformations:**
```m
// Remove empty rows and standardize column names
let
    Source = Excel.Workbook(File.Contents("data.xlsx"), null, true),
    Sheet = Source{[Name="Sales"]}[Data],
    Promoted = Table.PromoteHeaders(Sheet),
    Renamed = Table.RenameColumns(Promoted, {{"Order Date", "OrderDate"}, {"Customer ID", "CustomerID"}}),
    Typed = Table.TransformColumnTypes(Renamed, {
        {"OrderDate", type date},
        {"Amount", type number},
        {"CustomerID", Int64.Type}
    }),
    Filtered = Table.SelectRows(Typed, each [Amount] <> null and [Amount] > 0),
    Added_YearMonth = Table.AddColumn(Filtered, "YearMonth",
        each Date.Year([OrderDate]) * 100 + Date.Month([OrderDate]), Int64.Type)
in
    Added_YearMonth
```

**Report design rules:**
- Max 5 visuals per page — more = confusion
- One primary insight per page — title is the insight ("Revenue grew 23% driven by enterprise segment")
- Use bookmarks for drill-through instead of multiple pages
- Slicers go top-left; key KPI cards go top-center
- Consistent color = consistent meaning: green = positive, red = negative, blue = neutral

---

### Mode 4: Tableau — Key Patterns

**Calculated fields:**
```
// Profit Ratio
SUM([Profit]) / SUM([Sales])

// Year-over-Year Growth
(SUM([Sales]) - LOOKUP(SUM([Sales]), -1)) / ABS(LOOKUP(SUM([Sales]), -1))

// Running Total
RUNNING_SUM(SUM([Sales]))

// Z-Score (for anomaly detection)
(SUM([Sales]) - WINDOW_AVG(SUM([Sales]))) / WINDOW_STDEV(SUM([Sales]))

// LOD (Level of Detail) — customer-level average for scatter
{ FIXED [Customer Name] : SUM([Sales]) }
```

**Dashboard actions:**
- Filter action: clicking a bar filters other charts — use for drill-down
- Highlight action: clicking highlights related marks — use for cross-reference
- URL action: clicking opens external link — use for detail pages

---

### Mode 5: Dashboard Design Principles

**The 5-second test:** someone unfamiliar should understand the main insight in 5 seconds. If they can't, redesign.

**Layout hierarchy (F-pattern reading):**
```
┌─────────────────────────────────────┐
│  TITLE: The Insight in Plain English │
│  KPI 1  │  KPI 2  │  KPI 3  │ KPI 4 │  ← Top: most important numbers
├──────────────────┬──────────────────┤
│  Primary Chart   │  Secondary Chart  │  ← Middle: trends and comparisons
│  (biggest)       │  (supporting)     │
├──────────────────┴──────────────────┤
│  Detail Table / Breakdown           │  ← Bottom: supporting detail
└─────────────────────────────────────┘
```

**Pre-attentive attributes (what the eye sees before thinking):**
- Color — use to highlight ONE thing, not everything
- Size — bigger = more important
- Position — left-right ordering implies comparison
- Enclosure — a box groups related things

**When to use color:**
```
# ONE highlight color — direct attention to what matters
df['color'] = df['category'].apply(
    lambda x: '#2563EB' if x == 'TARGET CATEGORY' else '#D1D5DB'
)
```

---

## Quality Gate

Before delivering any visualization:
- [ ] Chart type matches the data relationship (comparison/trend/distribution/etc.)
- [ ] Axes labeled with units
- [ ] No 3D charts, no pie charts with >5 slices
- [ ] Color used for meaning, not decoration
- [ ] Title states the insight, not just the topic ("Revenue by Quarter" → "Revenue grew 34% YoY driven by Q3 enterprise surge")
- [ ] For Power BI: data model is star schema, not flat table
- [ ] For Plotly: interactive hover shows useful information
- [ ] Readable at 100% zoom — no tiny fonts
