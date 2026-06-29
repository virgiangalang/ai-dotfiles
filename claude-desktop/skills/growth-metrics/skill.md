---
name: growth-metrics
description: Marketing and growth KPI framework — AARRR, CPL/MQL/SQL/CAC/LTV, funnel conversion rates, attribution modeling, and executive dashboard. Pairs with data-analytics for calculation, ads-performance for paid channel metrics, and stakeholder-comms for presenting metrics to leadership. For growth marketers, CMOs, and analysts measuring what matters.
---

# Growth Metrics

## Skill Stack

- `data-analytics` — calculate all metrics from actual data; no benchmarks without current-state numbers
- `ads-performance` — paid channel metrics (CPL, CPA, ROAS) feed into growth funnel
- `marketing-strategy` — metrics must map to funnel stages (TOFU/MOFU/BOFU); strategy determines which metrics matter
- `stakeholder-comms` — present growth dashboard to board, investors, or leadership in decision-grade format

## Guardrails

- Never present a metric without also presenting the trend — a number without context (MoM, YoY, vs. target) is meaningless
- Vanity metrics (impressions, follower count, pageviews) are not growth metrics — always push toward conversion metrics
- CAC calculation must include ALL marketing and sales costs (not just ad spend) — underestimating CAC is the most common growth accounting error
- LTV calculation must be honest about churn — optimistic churn assumptions produce LTV numbers that make the business look better than it is
- MQL definition must be agreed with the sales team before reporting — if marketing and sales disagree on what an MQL is, the metric is useless

## The Growth Accounting Framework (AARRR)

| Stage | Metric | Formula | Good Benchmark |
|-------|--------|---------|---------------|
| **Acquisition** | Visitors, CPL, CAC | See below | Varies by channel |
| **Activation** | Trial → Active, Day 1 retention | Activated users / Signups | >40% (SaaS) |
| **Retention** | D7, D30, Monthly churn | Returning users / Total users | <5% monthly churn (B2B SaaS) |
| **Referral** | K-factor, referral rate | Invites sent × Invite conversion | >0.5 = some virality |
| **Revenue** | MRR, ARR, ARPU | See below | Depends on stage |

## Funnel Metrics Library

### Acquisition Metrics

```python
CPL = Total Marketing Spend / Number of Leads
Cost_per_MQL = Total Marketing Spend / Number of MQLs
Cost_per_SQL = Total Marketing Spend / Number of SQLs
CAC = (Total Marketing Spend + Total Sales Spend) / Number of New Customers
# Common mistake: using only ad spend for CAC — include salaries, tools, events

# Channel-specific CAC
CAC_paid = Paid Ad Spend / Customers_from_paid
CAC_organic = (Content + SEO spend) / Customers_from_organic
CAC_blended = Total Acquisition Spend / All New Customers
```

### MQL and SQL Definition Framework

**MQL (Marketing Qualified Lead):** A lead that has met a scoring threshold indicating likelihood to buy. Defined jointly by marketing and sales.

**MQL Scoring Example:**
```
DEMOGRAPHIC FIT (max 50 points):
  ICP industry: +20
  ICP company size: +15
  ICP job title / seniority: +15

BEHAVIORAL ENGAGEMENT (max 50 points):
  Opened email: +5
  Clicked email CTA: +10
  Visited pricing page: +15
  Downloaded gated content: +10
  Attended webinar: +10
  Requested demo: +15 (auto-MQL regardless of score)

Threshold: ≥50 points = MQL
```

**SQL (Sales Qualified Lead):** MQL that sales has accepted after initial contact and confirmed BANT (Budget, Authority, Need, Timeline).

```python
MQL_to_SQL_rate = SQLs / MQLs × 100           # Target: >20%
SQL_to_Close_rate = Closed Won / SQLs × 100   # Target: >25%
```

### Revenue Metrics

```python
MRR = Sum of all monthly recurring revenue from active subscriptions
ARR = MRR × 12

New_MRR = Revenue from new customers this month
Expansion_MRR = Revenue from upsells/cross-sells this month
Churned_MRR = Revenue lost from churned customers this month
Net_New_MRR = New_MRR + Expansion_MRR - Churned_MRR

ARPU = MRR / Number of Active Customers     # Average Revenue Per User
ARPA = MRR / Number of Active Accounts      # Average Revenue Per Account (B2B)

# LTV Calculation
Churn_Rate = Churned Customers / Total Customers × 100   # Monthly
Customer_Lifetime = 1 / Monthly_Churn_Rate               # In months
LTV = ARPU × Customer_Lifetime                           # Simple
LTV = ARPU × Gross_Margin × Customer_Lifetime            # Gross margin adjusted

# Unit Economics
LTV_to_CAC = LTV / CAC                    # Target: >3:1 (SaaS), >5:1 (enterprise)
Payback_Period = CAC / (ARPU × Gross_Margin)  # Months — target: <12 months

# Growth
MoM_Growth = (MRR_this_month - MRR_last_month) / MRR_last_month × 100
CMGR = (MRR_end / MRR_start) ^ (1/n_months) - 1     # Compounded monthly
Rule_of_40 = Revenue_Growth_Rate + EBITDA_Margin     # >40 = healthy SaaS
```

### Funnel Conversion Benchmarks (B2B SaaS)

| Funnel Step | Good | Needs Work |
|------------|------|-----------|
| Visitor → Lead (CPL) | <$50 (SMB) / <$200 (Enterprise) | >$200 / >$500 |
| Lead → MQL | >30% | <15% |
| MQL → SQL | >25% | <15% |
| SQL → Opportunity | >50% | <30% |
| Opportunity → Close | >25% | <15% |
| Overall Visitor → Customer | >1% | <0.5% |

## Attribution Models

| Model | How It Works | Best For |
|-------|-------------|---------|
| First Touch | 100% credit to first channel that touched lead | Understanding awareness channels |
| Last Touch | 100% credit to last channel before conversion | Understanding conversion channels |
| Linear | Equal credit to all touchpoints | Simple multi-touch |
| Time Decay | More credit to recent touchpoints | Short sales cycles |
| Position-Based (U-shaped) | 40% first + 40% last + 20% middle | Balanced view |
| Data-Driven | ML-based attribution from actual conversion paths | Scale (needs volume data) |

**Recommendation:** Use First Touch to evaluate top-of-funnel channel performance. Use Last Touch to evaluate conversion channel performance. Use both — not one.

## Growth Dashboard Template

```
GROWTH DASHBOARD — [Month Year]
──────────────────────────────────────────────────
PIPELINE HEALTH
  New Leads:          [X] (↑/↓ Y% MoM)
  MQLs:               [X] (↑/↓ Y% MoM)
  SQLs:               [X] (↑/↓ Y% MoM)
  Pipeline Value:     $X (↑/↓ Y% MoM)

REVENUE
  MRR:                $X (↑/↓ Y% MoM)
  Net New MRR:        $X (New: $X | Expansion: $X | Churn: -$X)
  ARR:                $X
  
UNIT ECONOMICS
  Blended CAC:        $X
  LTV:                $X
  LTV:CAC:            X.X:1
  Payback Period:     X months

CHANNEL PERFORMANCE
  Paid Search CPL:    $X (ROAS: X.X)
  Paid Social CPL:    $X (ROAS: X.X)
  Organic/SEO:        X leads
  Email:              X leads (CTR: X%)
  
RETENTION
  Monthly Churn:      X%
  D30 Retention:      X%
  NPS:                X

RED FLAGS (metrics outside target range):
  [Flag with owner and action]
```

## Quality Gate

Before presenting growth metrics to leadership:
- [ ] CAC includes both marketing AND sales costs (not just ad spend)
- [ ] LTV uses actual churn rate, not optimistic assumption
- [ ] MQL definition is agreed with sales — not just marketing's definition
- [ ] Every metric shows trend (MoM % change) not just absolute number
- [ ] Attribution model clearly stated (first touch, last touch, etc.)
- [ ] Red flags surfaced explicitly — don't bury bad metrics in tables
- [ ] Top 3 recommended actions based on the data are included
