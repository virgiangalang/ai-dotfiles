---
description: Run a complete exploratory data analysis (EDA) on a dataset. Produces data quality audit, statistical summary, key distributions, correlations, trends, anomalies, and a business insight summary with recommended actions.
---

Load the `data-analytics` and `data-visualization` skills. Activate the `data-analyst` agent.

Run a complete EDA. Deliver in this order:

**1. Data Quality Audit**
```python
print(df.shape)
print(df.dtypes)
print(df.isnull().sum())
print(df.describe())
print(df.duplicated().sum())
```
Flag: missing values >5%, wrong data types, obvious outliers, duplicate rows.

**2. Statistical Summary**
- For each numeric column: mean, median, std, min, max, P25, P75, P90
- Skewness: is the distribution normal or heavy-tailed?
- For each categorical column: unique values, top 5 by frequency

**3. Distributions**
- Histogram for each key numeric column
- Bar chart for top categorical values (max top 10)
- Flag any bimodal distributions or extreme skew

**4. Correlations**
- Correlation matrix for all numeric columns
- Highlight: any correlation >0.7 (potential multicollinearity) or <-0.5

**5. Time Series (if date column exists)**
- Plot the primary metric over time
- Identify: trend direction, seasonality (day-of-week, monthly patterns), anomalies

**6. Anomaly Detection**
Apply Z-score (flag >3 std dev) and IQR method (flag 1.5× IQR beyond Q1/Q3).
For each anomaly: is it a data error or a real signal?

**7. Business Insight Summary**
Use the executive output format from `data-analytics` Mode 4:
- Headline numbers (top 3 KPIs)
- Key findings (top 3 non-obvious insights)
- Red flags (requires action)
- Recommended actions (specific, measurable)

Produce runnable Python code for every analysis step. If data has >100K rows, sample 10K for EDA speed.
