---
name: predictive-analytics
description: Predictive analytics and forecasting from historical data — revenue, customers, AOV, hiring, churn, financial runway, any business metric. Upload a CSV and get a production-ready forecast with confidence intervals, scenario planning, and actionable recommendations.
---

# Predictive Analytics Skill

## Skill Stack

```
predictive-analytics
├── data-analytics          ← data profiling, KPI understanding
├── data-visualization      ← forecast charts, confidence bands
└── sql-analytics           ← historical data extraction
```

## Guardrails

- **NEVER** claim a prediction is "certain" — always show confidence intervals and error margins
- **ALWAYS** ask for historical data length before selecting a model (< 12 months → regression; 12–24 months → Prophet/ARIMA; 24+ months → full time series)
- **NEVER** use future-date data as a predictor variable (data leakage)
- **ALWAYS** explain model assumptions in plain language before showing numbers
- **NEVER** skip the data quality check step — garbage in, garbage out
- **ALWAYS** show at least 3 scenarios: pessimistic / base / optimistic
- **ALWAYS** include what could break the forecast (key assumptions + risks)
- **NEVER** predict beyond 2× the length of historical data (e.g., 12 months history → max 24 months forecast)

## Operating Modes

---

### Mode 1: Data Upload & Profiling

**When to use:** First step before any prediction. Understand what you have.

```python
import pandas as pd
import numpy as np

def profile_dataset(filepath: str) -> dict:
    """Profile uploaded CSV for prediction readiness."""
    df = pd.read_csv(filepath, parse_dates=True, infer_datetime_format=True)

    # Detect date column
    date_cols = [c for c in df.columns if df[c].dtype == 'object'
                 and pd.to_datetime(df[c], errors='coerce').notna().mean() > 0.8]
    numeric_cols = df.select_dtypes(include=np.number).columns.tolist()

    report = {
        "rows": len(df),
        "columns": len(df.columns),
        "date_columns": date_cols,
        "numeric_columns": numeric_cols,
        "date_range": None,
        "missing_pct": (df.isnull().sum() / len(df) * 100).round(2).to_dict(),
        "data_quality_score": None,
        "prediction_ready": False,
        "recommended_model": None,
        "warnings": []
    }

    if date_cols:
        df[date_cols[0]] = pd.to_datetime(df[date_cols[0]])
        df = df.sort_values(date_cols[0])
        date_range = df[date_cols[0]].max() - df[date_cols[0]].min()
        report["date_range"] = str(date_range.days) + " days"
        months = date_range.days / 30

        if months < 3:
            report["warnings"].append("Less than 3 months of data — predictions will be low confidence")
            report["recommended_model"] = "linear_regression"
        elif months < 12:
            report["recommended_model"] = "exponential_smoothing"
        elif months < 24:
            report["recommended_model"] = "prophet"
        else:
            report["recommended_model"] = "prophet_with_seasonality"

    # Quality score
    avg_missing = np.mean(list(report["missing_pct"].values()))
    report["data_quality_score"] = max(0, 100 - avg_missing * 2)
    report["prediction_ready"] = report["data_quality_score"] > 60

    return report
```

**Data Quality Checklist:**
- [ ] At least one date/time column exists
- [ ] At least one numeric target column (revenue, customers, orders)
- [ ] No more than 20% missing values in target column
- [ ] Minimum 3 months of data (12+ months preferred)
- [ ] No extreme unexplained spikes (check for data entry errors)

---

### Mode 2: Time Series Forecasting (Revenue / Customers / Orders)

**When to use:** Predict a business metric forward in time from its own history.

```python
from prophet import Prophet
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

def forecast_metric(
    df: pd.DataFrame,
    date_col: str,
    value_col: str,
    periods: int = 12,         # months to forecast
    freq: str = "MS",          # MS = month start
    yearly_seasonality: bool = True,
    weekly_seasonality: bool = False,
    include_holidays: str = None  # "ID" for Indonesia, "US" for US, etc.
) -> dict:
    """
    Forecast any business metric using Prophet.
    Returns: forecast df, model, metrics, chart.
    """
    # Prepare Prophet format
    prophet_df = df[[date_col, value_col]].rename(
        columns={date_col: "ds", value_col: "y"}
    )
    prophet_df["ds"] = pd.to_datetime(prophet_df["ds"])
    prophet_df = prophet_df.dropna()

    # Build model
    model = Prophet(
        yearly_seasonality=yearly_seasonality,
        weekly_seasonality=weekly_seasonality,
        daily_seasonality=False,
        seasonality_mode="multiplicative",  # better for growing businesses
        interval_width=0.80,                # 80% confidence interval
        changepoint_prior_scale=0.05        # controls flexibility
    )

    if include_holidays:
        model.add_country_holidays(country_name=include_holidays)

    model.fit(prophet_df)

    # Create future dataframe
    future = model.make_future_dataframe(periods=periods, freq=freq)
    forecast = model.predict(future)

    # Extract key results
    forecast_only = forecast[forecast["ds"] > prophet_df["ds"].max()]
    result = {
        "forecast": forecast_only[["ds", "yhat", "yhat_lower", "yhat_upper"]],
        "peak_month": forecast_only.loc[forecast_only["yhat"].idxmax(), "ds"],
        "end_of_period": forecast_only.iloc[-1]["yhat"],
        "growth_pct": ((forecast_only.iloc[-1]["yhat"] / prophet_df["y"].iloc[-1]) - 1) * 100,
        "model": model,
        "full_forecast": forecast
    }

    # Back-test accuracy
    from sklearn.metrics import mean_absolute_percentage_error
    historical_forecast = forecast[forecast["ds"] <= prophet_df["ds"].max()]
    mape = mean_absolute_percentage_error(
        prophet_df["y"].values,
        historical_forecast["yhat"].values[:len(prophet_df)]
    )
    result["mape"] = round(mape * 100, 2)
    result["accuracy"] = round((1 - mape) * 100, 2)

    return result


def plot_forecast(result: dict, metric_name: str, currency: bool = False):
    """Plot forecast with confidence bands."""
    full = result["full_forecast"]
    fmt = "${:,.0f}" if currency else "{:,.0f}"

    fig, ax = plt.subplots(figsize=(14, 6))
    ax.plot(full["ds"], full["yhat"], color="#2563EB", linewidth=2, label="Forecast")
    ax.fill_between(full["ds"], full["yhat_lower"], full["yhat_upper"],
                    alpha=0.15, color="#2563EB", label="80% Confidence Interval")

    # Mark forecast start
    split = full["ds"].iloc[-result["forecast"].shape[0]]
    ax.axvline(split, color="#DC2626", linestyle="--", alpha=0.7, label="Forecast Start")

    ax.set_title(f"{metric_name} Forecast", fontsize=16, fontweight="bold")
    ax.set_xlabel("Date")
    ax.set_ylabel(metric_name)
    ax.yaxis.set_major_formatter(plt.FuncFormatter(
        lambda x, _: fmt.format(x)
    ))
    ax.legend()
    ax.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(f"{metric_name.lower().replace(' ', '_')}_forecast.png", dpi=150)
    plt.show()
```

**Output template:**

```
📈 FORECAST SUMMARY — [METRIC NAME]
══════════════════════════════════════════════════════

Historical period : [start] → [end]  ([N] months)
Forecast horizon  : [N] months forward
Model accuracy    : [X]% (MAPE [X]%)

MONTHLY FORECAST
Month       Base Case    Pessimistic    Optimistic
──────────────────────────────────────────────────
[Month 1]   [value]      [yhat_lower]   [yhat_upper]
[Month 2]   [value]      [yhat_lower]   [yhat_upper]
...
[Month N]   [value]      [yhat_lower]   [yhat_upper]

SUMMARY
  End-of-period (base): [value]
  vs. today           : [+X% / -X%]
  Peak month          : [month]

KEY ASSUMPTIONS
  - Seasonal patterns from historical data continue
  - No major product/pricing changes
  - [add business-specific assumptions]

WHAT COULD BREAK THIS FORECAST
  - [risk 1]
  - [risk 2]
```

---

### Mode 3: Financial Projection (Revenue / P&L / Runway)

**When to use:** Project financial statements, calculate runway, predict break-even.

```python
import numpy as np
import pandas as pd

def financial_projection(
    monthly_revenue: list[float],     # historical monthly revenue
    monthly_costs_fixed: float,       # fixed costs per month (rent, salaries)
    monthly_costs_variable_pct: float, # variable costs as % of revenue (COGS, etc.)
    cash_balance: float,              # current cash
    projection_months: int = 24
) -> dict:
    """
    Project revenue, costs, profit, and runway.
    Uses regression on revenue trend + fixed cost structure.
    """
    from sklearn.linear_model import LinearRegression
    from sklearn.preprocessing import PolynomialFeatures

    # Fit revenue trend
    X = np.arange(len(monthly_revenue)).reshape(-1, 1)
    y = np.array(monthly_revenue)

    # Try linear vs polynomial — pick better fit
    poly = PolynomialFeatures(degree=2, include_bias=False)
    X_poly = poly.fit_transform(X)

    model_lin = LinearRegression().fit(X, y)
    model_poly = LinearRegression().fit(X_poly, y)

    r2_lin = model_lin.score(X, y)
    r2_poly = model_poly.score(X_poly, y)

    # Future months
    future_X = np.arange(len(monthly_revenue), len(monthly_revenue) + projection_months).reshape(-1, 1)

    if r2_poly > r2_lin + 0.05:
        future_X_poly = poly.transform(future_X)
        revenue_forecast = model_poly.predict(future_X_poly)
        model_used = "polynomial_regression"
    else:
        revenue_forecast = model_lin.predict(future_X)
        model_used = "linear_regression"

    # Apply growth floor — revenue shouldn't go negative
    revenue_forecast = np.maximum(revenue_forecast, 0)

    # Scenario multipliers
    scenarios = {
        "pessimistic": 0.75,
        "base": 1.00,
        "optimistic": 1.30
    }

    results = {}
    for scenario, multiplier in scenarios.items():
        rev = revenue_forecast * multiplier
        variable_costs = rev * monthly_costs_variable_pct
        total_costs = monthly_costs_fixed + variable_costs
        gross_profit = rev - variable_costs
        net_profit = rev - total_costs
        cumulative_cash = cash_balance + np.cumsum(net_profit)

        # Runway
        negative_months = np.where(cumulative_cash < 0)[0]
        runway = negative_months[0] if len(negative_months) > 0 else projection_months

        # Break-even month
        breakeven = np.where(net_profit > 0)[0]
        breakeven_month = breakeven[0] + 1 if len(breakeven) > 0 else None

        results[scenario] = {
            "monthly_revenue": rev.tolist(),
            "monthly_net_profit": net_profit.tolist(),
            "cumulative_cash": cumulative_cash.tolist(),
            "runway_months": int(runway),
            "breakeven_month": breakeven_month,
            "total_revenue_period": float(rev.sum()),
            "total_profit_period": float(net_profit.sum())
        }

    results["model_used"] = model_used
    results["r2_score"] = round(max(r2_lin, r2_poly), 3)
    return results


def format_financial_projection(results: dict, currency: str = "IDR"):
    """Format financial projection for display."""
    fmt = "Rp {:,.0f}" if currency == "IDR" else "${:,.0f}"

    print("💰 FINANCIAL PROJECTION")
    print("=" * 60)
    for scenario in ["pessimistic", "base", "optimistic"]:
        d = results[scenario]
        print(f"\n📊 {scenario.upper()} SCENARIO")
        print(f"  Total Revenue (period): {fmt.format(d['total_revenue_period'])}")
        print(f"  Total Profit  (period): {fmt.format(d['total_profit_period'])}")
        print(f"  Runway                : {d['runway_months']} months")
        if d["breakeven_month"]:
            print(f"  Break-even            : Month {d['breakeven_month']}")
        else:
            print(f"  Break-even            : Already profitable")
```

---

### Mode 4: Customer & Growth Prediction

**When to use:** Predict new customers, active users, churn rate, and net customer growth.

```python
import pandas as pd
import numpy as np
from prophet import Prophet

def predict_customer_growth(
    df: pd.DataFrame,
    date_col: str,
    new_customers_col: str,
    churned_customers_col: str = None,
    active_customers_col: str = None,
    periods: int = 12
) -> dict:
    """
    Predict new customers, churn, and net customer growth.
    Also computes LTV trajectory if avg_revenue_per_customer is available.
    """
    results = {}

    # Predict new customer acquisition
    new_cust_model = Prophet(
        seasonality_mode="multiplicative",
        interval_width=0.80,
        changepoint_prior_scale=0.1
    )
    new_cust_df = df[[date_col, new_customers_col]].rename(
        columns={date_col: "ds", new_customers_col: "y"}
    )
    new_cust_df["ds"] = pd.to_datetime(new_cust_df["ds"])
    new_cust_model.fit(new_cust_df)
    future = new_cust_model.make_future_dataframe(periods=periods, freq="MS")
    new_cust_forecast = new_cust_model.predict(future)
    results["new_customers"] = new_cust_forecast[["ds", "yhat", "yhat_lower", "yhat_upper"]].tail(periods)

    # Predict churn if data available
    if churned_customers_col and churned_customers_col in df.columns:
        churn_model = Prophet(interval_width=0.80)
        churn_df = df[[date_col, churned_customers_col]].rename(
            columns={date_col: "ds", churned_customers_col: "y"}
        )
        churn_df["ds"] = pd.to_datetime(churn_df["ds"])
        churn_model.fit(churn_df)
        churn_forecast = churn_model.predict(future)
        results["churned_customers"] = churn_forecast[["ds", "yhat"]].tail(periods)

        # Net customer growth
        net = results["new_customers"].copy()
        net["net_growth"] = results["new_customers"]["yhat"].values - results["churned_customers"]["yhat"].values
        results["net_growth"] = net

    # Cumulative active customers (if start count known)
    if active_customers_col and active_customers_col in df.columns:
        current_active = df[active_customers_col].iloc[-1]
        net_monthly = results.get("net_growth", results["new_customers"])["yhat" if "net_growth" not in results.get("net_growth", {}) else "net_growth"].values
        cumulative = current_active + np.cumsum(net_monthly)
        results["cumulative_active"] = cumulative.tolist()

    return results


def churn_rate_prediction(
    df: pd.DataFrame,
    cohort_col: str,
    period_col: str,
    retained_col: str
) -> pd.DataFrame:
    """Build survival curve from cohort data to predict future churn."""
    pivot = df.pivot_table(values=retained_col, index=cohort_col, columns=period_col)
    cohort_size = pivot.iloc[:, 0]
    retention = pivot.divide(cohort_size, axis=0) * 100

    # Average retention curve
    avg_retention = retention.mean()

    # Project forward using geometric decay fit
    periods = len(avg_retention)
    X = np.arange(periods)
    known = avg_retention.dropna().values

    from scipy.optimize import curve_fit
    def decay(x, a, b):
        return a * np.exp(-b * x)

    try:
        popt, _ = curve_fit(decay, np.arange(len(known)), known, p0=[100, 0.1])
        future_periods = np.arange(periods, periods + 12)
        predicted = decay(future_periods, *popt)
    except Exception:
        predicted = [known[-1]] * 12

    return {
        "avg_retention_curve": avg_retention.to_dict(),
        "predicted_future_retention": dict(zip(range(periods, periods + 12), predicted)),
        "estimated_12m_retention": float(predicted[-1])
    }
```

---

### Mode 5: AOV & Revenue Per Customer Prediction

**When to use:** Predict Average Order Value trends, ARPU (Average Revenue Per User), and revenue per customer segment.

```python
import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import cross_val_score
from sklearn.preprocessing import StandardScaler

def predict_aov(
    df: pd.DataFrame,
    date_col: str,
    aov_col: str,               # average order value per period
    feature_cols: list = None,  # optional: promo_flag, season, channel, etc.
    periods: int = 6
) -> dict:
    """
    Predict future AOV.
    With features → GradientBoosting regression.
    Without features → time series extrapolation.
    """
    df = df.copy()
    df[date_col] = pd.to_datetime(df[date_col])
    df = df.sort_values(date_col)

    if feature_cols and all(c in df.columns for c in feature_cols):
        # Feature-based prediction
        X = df[feature_cols]
        y = df[aov_col]

        scaler = StandardScaler()
        X_scaled = scaler.fit_transform(X)

        model = GradientBoostingRegressor(n_estimators=100, random_state=42)
        cv_scores = cross_val_score(model, X_scaled, y, cv=3, scoring="r2")
        model.fit(X_scaled, y)

        feature_importance = dict(zip(feature_cols, model.feature_importances_))

        return {
            "model": "gradient_boosting",
            "cv_r2": round(np.mean(cv_scores), 3),
            "feature_importance": dict(sorted(feature_importance.items(), key=lambda x: -x[1])),
            "current_aov": float(y.iloc[-1]),
            "insight": "Use feature importances to understand what drives AOV changes"
        }
    else:
        # Time-only extrapolation
        X = np.arange(len(df)).reshape(-1, 1)
        y = df[aov_col].values

        model = LinearRegression()
        model.fit(X, y)
        r2 = model.score(X, y)

        future_X = np.arange(len(df), len(df) + periods).reshape(-1, 1)
        forecast = model.predict(future_X)

        # Add noise estimate from historical volatility
        std = np.std(y - model.predict(X))

        return {
            "model": "linear_regression",
            "r2": round(r2, 3),
            "current_aov": float(y[-1]),
            "forecast": [
                {
                    "period": i + 1,
                    "aov_base": round(float(v), 2),
                    "aov_low": round(float(v - 1.28 * std), 2),   # 80% CI
                    "aov_high": round(float(v + 1.28 * std), 2)
                }
                for i, v in enumerate(forecast)
            ],
            "trend": "increasing" if model.coef_[0] > 0 else "decreasing",
            "monthly_change": round(float(model.coef_[0]), 2)
        }
```

---

### Mode 6: Hiring Plan Prediction

**When to use:** Predict when to hire, how many headcount, based on revenue growth or workload metrics.

```python
import pandas as pd
import numpy as np

def predict_hiring_plan(
    monthly_revenue_forecast: list[float],     # from Mode 2 or Mode 3
    current_headcount: int,
    revenue_per_employee_target: float,        # e.g., 500_000_000 IDR/employee/year
    current_annual_salary: float,              # average total comp per employee
    hiring_lead_time_months: int = 2,          # how long to hire
    departments: dict = None                   # optional: dept split %
) -> dict:
    """
    Predict headcount needs and hiring timeline from revenue forecast.
    """
    monthly_revenue = np.array(monthly_revenue_forecast)
    annual_revenue_run_rate = monthly_revenue * 12
    required_headcount = np.ceil(annual_revenue_run_rate / revenue_per_employee_target).astype(int)

    # Current headcount baseline
    headcount_delta = np.maximum(0, required_headcount - current_headcount)

    # Hiring schedule (shifted by lead time)
    hiring_schedule = np.zeros(len(monthly_revenue), dtype=int)
    for i, delta in enumerate(headcount_delta):
        if delta > 0:
            trigger_month = max(0, i - hiring_lead_time_months)
            hiring_schedule[trigger_month] += delta

    # Cost projection
    monthly_salary_cost = (current_headcount + np.cumsum(hiring_schedule)) * (current_annual_salary / 12)

    plan = []
    cumulative_hires = 0
    for i in range(len(monthly_revenue)):
        cumulative_hires += hiring_schedule[i]
        plan.append({
            "month": i + 1,
            "projected_revenue": round(monthly_revenue[i]),
            "required_headcount": int(required_headcount[i]),
            "hire_this_month": int(hiring_schedule[i]),
            "cumulative_headcount": current_headcount + cumulative_hires,
            "monthly_salary_cost": round(monthly_salary_cost[i])
        })

    # Department breakdown
    if departments:
        dept_hiring = {}
        total_hires = int(np.sum(hiring_schedule))
        for dept, pct in departments.items():
            dept_hiring[dept] = round(total_hires * pct)
    else:
        dept_hiring = None

    return {
        "hiring_plan": plan,
        "total_hires_period": int(np.sum(hiring_schedule)),
        "end_headcount": current_headcount + int(np.sum(hiring_schedule)),
        "total_salary_cost_period": round(float(monthly_salary_cost.sum())),
        "department_breakdown": dept_hiring
    }


def format_hiring_plan(result: dict, currency: str = "IDR"):
    fmt = "Rp {:,.0f}" if currency == "IDR" else "${:,.0f}"
    print("👥 HIRING PLAN FORECAST")
    print("=" * 60)
    print(f"Total hires needed : {result['total_hires_period']} people")
    print(f"End headcount      : {result['end_headcount']} people")
    print(f"Total salary cost  : {fmt.format(result['total_salary_cost_period'])}")
    print()
    print(f"{'Month':<8} {'Revenue':<20} {'Headcount':<12} {'Hire':<8} {'Salary Cost'}")
    print("-" * 65)
    for row in result["hiring_plan"]:
        if row["hire_this_month"] > 0 or row["month"] % 3 == 0:
            print(f"M{row['month']:<7} {fmt.format(row['projected_revenue']):<20} "
                  f"{row['cumulative_headcount']:<12} +{row['hire_this_month']:<7} "
                  f"{fmt.format(row['monthly_salary_cost'])}")
```

---

### Mode 7: Scenario Planning & Monte Carlo Simulation

**When to use:** When uncertainty is high and you need probability distributions, not just point estimates.

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def monte_carlo_forecast(
    base_monthly_growth_rate: float,    # e.g., 0.08 for 8% MoM
    growth_rate_std: float,             # uncertainty in growth rate, e.g., 0.04
    starting_value: float,              # e.g., current MRR
    periods: int = 12,
    simulations: int = 10_000,
    percentiles: list = [10, 25, 50, 75, 90]
) -> dict:
    """
    Monte Carlo simulation for any business metric.
    Returns percentile distribution of outcomes.
    """
    rng = np.random.default_rng(42)

    # Simulate N paths
    results = np.zeros((simulations, periods))
    for sim in range(simulations):
        value = starting_value
        for month in range(periods):
            growth = rng.normal(base_monthly_growth_rate, growth_rate_std)
            value = value * (1 + growth)
            value = max(value, 0)  # floor at 0
            results[sim, month] = value

    # Compute percentiles at each period
    percentile_results = {}
    for p in percentiles:
        percentile_results[f"p{p}"] = np.percentile(results, p, axis=0).tolist()

    end_values = results[:, -1]

    return {
        "percentiles": percentile_results,
        "end_value": {
            f"p{p}": round(float(np.percentile(end_values, p)))
            for p in percentiles
        },
        "probability_of_growth": float(np.mean(end_values > starting_value) * 100),
        "probability_of_decline": float(np.mean(end_values < starting_value) * 100),
        "median_end_value": float(np.median(end_values)),
        "worst_case_p10": float(np.percentile(end_values, 10)),
        "best_case_p90": float(np.percentile(end_values, 90))
    }


def plot_monte_carlo(result: dict, metric_name: str, currency: bool = False):
    """Fan chart for Monte Carlo results."""
    fig, ax = plt.subplots(figsize=(14, 7))
    periods = range(1, len(result["percentiles"]["p50"]) + 1)
    fmt = "${:,.0f}" if currency else "{:,.0f}"

    # Fan layers
    ax.fill_between(periods, result["percentiles"]["p10"], result["percentiles"]["p90"],
                    alpha=0.10, color="#2563EB", label="10th–90th percentile")
    ax.fill_between(periods, result["percentiles"]["p25"], result["percentiles"]["p75"],
                    alpha=0.20, color="#2563EB", label="25th–75th percentile")
    ax.plot(periods, result["percentiles"]["p50"],
            color="#2563EB", linewidth=2.5, label="Median (50th percentile)")

    ax.set_title(f"{metric_name} — Monte Carlo Simulation ({10_000:,} paths)", fontsize=15, fontweight="bold")
    ax.set_xlabel("Month")
    ax.set_ylabel(metric_name)
    ax.yaxis.set_major_formatter(plt.FuncFormatter(lambda x, _: fmt.format(x)))
    ax.legend()
    ax.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig(f"{metric_name.lower().replace(' ', '_')}_montecarlo.png", dpi=150)
    plt.show()
```

---

## Quality Gates

Before delivering any prediction, verify ALL of these:

- [ ] **Data quality**: > 60% quality score, < 20% missing in target column
- [ ] **Minimum data**: at least 3 months (warn if < 12 months)
- [ ] **Model accuracy shown**: MAPE or R² must be stated explicitly
- [ ] **Confidence intervals included**: never show a single point forecast only
- [ ] **3 scenarios minimum**: pessimistic / base / optimistic
- [ ] **Assumptions listed**: at least 3 key assumptions written out
- [ ] **Risks identified**: at least 2 "what could break this forecast" items
- [ ] **Forecast horizon check**: not beyond 2× historical data length
- [ ] **Plain language summary**: numbers translated into business English, not just raw output
- [ ] **Visualization**: at least one chart (forecast line or fan chart)

## When to Use Which Mode

| Situation | Mode |
|-----------|------|
| "upload this CSV and predict X" | Mode 1 → Mode 2 |
| "predict our revenue next 12 months" | Mode 2 (Prophet) |
| "project our P&L and runway" | Mode 3 (Financial) |
| "how many customers will we have?" | Mode 4 (Customer) |
| "predict AOV next quarter" | Mode 5 (AOV) |
| "when do we need to hire?" | Mode 6 (Hiring) |
| "what's the probability we hit target?" | Mode 7 (Monte Carlo) |
| "best/base/worst case scenario" | Mode 7 (Monte Carlo) |
| "how will churn affect our growth?" | Mode 4 + Mode 7 |

## Required Libraries

```bash
pip install prophet scikit-learn scipy pandas numpy matplotlib
```

Or with conda:
```bash
conda install -c conda-forge prophet scikit-learn scipy
```
