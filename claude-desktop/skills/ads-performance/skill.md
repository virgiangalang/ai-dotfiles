---
name: ads-performance
description: Paid ads strategy and optimization across Google Ads, Meta Ads (Facebook/Instagram), and TikTok Ads. Covers campaign structure, bidding, creative testing, CPL/CPA/ROAS optimization, and campaign audit. Pairs with growth-metrics for KPI targets, copywriting for ad copy, and marketing-strategy for channel allocation. For growth marketers, ads managers, and CMOs running paid acquisition.
---

# Ads Performance

## Skill Stack

- `growth-metrics` — define CPL, CPA, ROAS targets before launching; know your target numbers
- `copywriting` — ad copy is a direct application of copywriting frameworks; brief the copy before creative
- `marketing-strategy` — paid ads are one channel in the mix; understand the full funnel before over-investing
- `data-analytics` — campaign data analysis, attribution modeling, anomaly detection in performance data
- `brand-strategy` — ad creative must be on-brand; consistency builds recognition and reduces CPL over time

## Guardrails

- Never launch a paid campaign without defined target CPL and ROAS — you need a number to optimize toward
- Never run a single creative variant — always A/B test at least 2 creatives from day 1; winner compounds
- Never set budgets at 100% without a 1–2 week learning phase; algorithms need data before optimizing
- A high CTR with low conversion rate signals a landing page problem, not an ads problem — diagnose correctly
- Google Search and Meta/TikTok serve different intent levels: Search = demand capture, Social = demand creation — never use identical KPIs for both

## Key Formulas

```python
CPL = Ad Spend / Number of Leads
CPC = Ad Spend / Clicks
CTR = (Clicks / Impressions) × 100          # Good: Search >3%, Social >1%
ROAS = Revenue from Ads / Ad Spend           # Target: >3x for ecommerce, >5x for high-margin
CPA = Ad Spend / Conversions
CPM = (Ad Spend / Impressions) × 1000       # Cost per 1000 impressions
Conversion Rate = Conversions / Clicks × 100
Impression Share = Your Impressions / Total Eligible Impressions × 100
# Google: Quality Score factors: Ad Relevance + Landing Page Experience + Expected CTR

Breakeven ROAS = 1 / Gross Margin
# Example: 60% gross margin → breakeven ROAS = 1.67; target >1.67 to be profitable
```

## Mode 1: Google Ads

**Campaign Structure:**
```
Account
└── Campaign (budget, bidding, geography, language)
    └── Ad Group (keyword theme, match types, bids)
        └── Ads (3–5 RSAs per ad group)
        └── Keywords (10–20 per ad group, tight theme)
```

**Campaign Types by Goal:**

| Goal | Campaign Type | Bidding Strategy |
|------|--------------|-----------------|
| Lead generation | Search | Target CPA |
| Brand awareness | Display / YouTube | Target CPM |
| High-intent conversion | Search + Performance Max | Maximize conversions |
| Retargeting | Display | Target CPA |
| App installs | UAC | Target CPA |

**Match Types:**
- `Broad`: widest reach, most AI control — use with Smart Bidding
- `[Exact]`: exact phrase only — use for high-intent, high-value terms
- `"Phrase"`: includes phrase in any order — balance of control and reach

**Search Ads Quality Score Optimization:**
- Ad Relevance: keyword should appear in headline 1 or 2
- Expected CTR: use action words, numbers, benefits in headlines
- Landing Page Experience: keyword → ad → landing page must be semantically consistent

**RSA (Responsive Search Ad) Best Practices:**
```
Headline 1: [Primary keyword or pain point]
Headline 2: [Key benefit]
Headline 3: [CTA or offer]
Description 1: [Expand on benefit + evidence]
Description 2: [Objection handling + CTA]

Use all 15 headline slots, all 4 description slots
Pin Headline 1 only if brand consistency requires it
```

**Negative Keywords:** Build a negative keyword list before launch. Add brand terms from competitors, irrelevant industries, and non-converting intent signals.

## Mode 2: Meta Ads (Facebook / Instagram)

**Campaign Structure:**
```
Campaign (objective: Leads / Conversions / Traffic / Awareness)
└── Ad Set (audience, budget, placement, schedule)
    └── Ads (creative variants — test: image vs. video, hook A vs. hook B)
```

**Audience Types:**

| Type | Best For | Notes |
|------|---------|-------|
| Core (Interest-based) | TOFU awareness | Broad to let AI optimize |
| Lookalike (1–5%) | Acquisition | Seed from best customers, not all leads |
| Custom (website visitors) | Retargeting MOFU | 30/60/90 day windows |
| Custom (email list) | Retargeting / exclusion | Upload existing customers to exclude |
| Broad (no targeting) | Scale with strong creative | Trust Meta's AI after 50+ conversions |

**Creative Testing Framework:**
- Test ONE variable at a time: hook vs. hook, or video vs. image — not both simultaneously
- Run each variant for minimum 3–5 days and 1000+ impressions before judging
- Kill losers at +30% higher CPL than target; scale winners with +20% budget per 3 days

**Hook Formula (first 3 seconds of video / first line of copy):**
```
Option A — Problem hook: "If you're struggling with [pain], this is for you."
Option B — Curiosity hook: "Most [ICP] don't know this about [topic]..."
Option C — Result hook: "How [customer] achieved [result] in [timeframe]"
Option D — Direct CTA: "Try [Product] free — [key benefit], no credit card"
```

**Meta Ads Creative Formats by Goal:**

| Format | Best For | Length |
|--------|---------|--------|
| Single image | Retargeting, clear offer | Static |
| Carousel | Product features, use cases | 3–10 cards |
| Video (vertical) | TOFU awareness, storytelling | 15–60s |
| UGC-style video | Trust building, mid-funnel | 30–90s |
| Lead form ad | Direct lead gen (no landing page) | Any |

## Mode 3: TikTok Ads

TikTok is **creative-first** — the creative IS the targeting. Strong creative reaches the right people.

**What works on TikTok:**
- Native-feeling content (not polished TV commercials)
- Hook in first 2 seconds — scroll-stopping opening
- Vertical 9:16 format, full screen
- Sound-on (use trending audio where possible)
- Text overlays for sound-off viewers
- Clear CTA in final 3 seconds

**Campaign Structure:**
```
Campaign (objective: Reach / Traffic / Lead Gen / App Install / Conversions)
└── Ad Group (targeting, budget, placement, bidding)
    └── Ads (3–5 creative variants minimum)
```

**TikTok Targeting:**
- Interest targeting: broad categories
- Behavioral targeting: users who engaged with content type
- Custom audiences: website visitors, email upload
- Lookalike: 1–5% similar to custom audiences

**Creative Hook Templates for TikTok:**
```
1. "POV: You just discovered [solution to pain]"
2. "[Number] things I wish I knew before [common experience]"
3. "The [industry] secret no one talks about..."
4. "[Controversial opinion] and here's why I'm right"
5. "Watch till the end — this changes everything about [topic]"
```

**Spark Ads:** Boost organic posts that are already performing — authentic, native, proven content.

## Mode 4: Campaign Audit Checklist

When diagnosing underperforming campaigns:

```
DIAGNOSIS FLOW
─────────────────────────────────────────────────
Step 1: Check impressions — is the ad being served?
  If low: budget too small / bid too low / audience too narrow

Step 2: Check CTR — are people clicking?
  Google Search benchmark: >3%
  Meta benchmark: >1%
  TikTok benchmark: >1.5%
  If low: creative / copy problem → test new hooks

Step 3: Check landing page conversion rate
  If click rate is fine but conversion is low:
  → Landing page problem, NOT an ads problem
  → Check page speed, headline match, CTA, form length

Step 4: Check lead quality
  High lead volume + low MQL rate = wrong audience / misleading ad
  → Tighten targeting / add qualifying questions to form

Step 5: Check cost trends
  Rising CPL = audience fatigue (rotate creative) or increased competition
  → Creative refresh every 2–4 weeks for social ads
```

## Mode 5: Budget Optimization

**Scaling Rules:**
- Increase budget by max 20% every 3 days — larger jumps reset the learning phase
- Scale the ad set, not just the ad, to maintain audience data
- Once a campaign exits learning phase (50+ conversions), it can be scaled more aggressively

**Portfolio Approach:**
| Budget % | Campaign Type | Purpose |
|----------|--------------|---------|
| 60% | Core converting campaigns | Defend what's working |
| 25% | Testing new creatives / audiences | Find the next winner |
| 15% | Retargeting | Close warm leads at low CPA |

## Quality Gate

Before declaring a campaign ready to launch:
- [ ] Campaign objective matches business goal (not just "get clicks")
- [ ] Target CPL / CPA / ROAS defined before launch
- [ ] Minimum 2 creative variants per ad set (A/B test from day 1)
- [ ] Conversion tracking verified (pixel / tag firing on goal action)
- [ ] Negative keyword list built (Google Search only)
- [ ] Landing page reviewed: keyword → ad → landing page consistency
- [ ] Budget set for minimum 7-day learning phase before optimization decisions
- [ ] UTM parameters on all URLs for attribution tracking
