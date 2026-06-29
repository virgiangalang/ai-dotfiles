---
name: business-model-canvas
description: Business Model Canvas (BMC) design, stress-testing, and iteration. Pairs with market-research (ECC) for customer segment validation, data-analytics for unit economics calculation, and pitch-deck when the BMC becomes investor-facing. Includes all 9 blocks, revenue model comparison, unit economics formulas, and quality gate.
---

# Business Model Canvas

## Skill Stack

- `market-research` (ECC) — validate customer segments with evidence before filling in the BMC; run TAM/SAM/SOM
- `data-analytics` — calculate unit economics (CAC, LTV, payback, gross margin) from real data
- `pitch-deck` — when the BMC needs to be communicated to investors or stakeholders
- `decision-framework` — when choosing between competing revenue models or partnership strategies
- `competitive-platform-analysis` (ECC) — understand competitor business models before designing yours

## Guardrails

- Do not fill in "Revenue Streams" without first answering: what would a customer actually pay for, and have you validated this?
- Unit economics (CAC, LTV, payback) must be calculated, not assumed — use `data-analytics` for this
- A BMC with empty "Customer Relationships" or "Channels" blocks is incomplete — these are where most startups fail
- Never describe the Value Proposition as features — describe it as outcomes for the customer
- The BMC is a hypothesis map, not a business plan — every block is an assumption to be validated, not a fact
- If the Value Proposition block can't be written in 2 sentences, the product's purpose is unclear

## Quality Gate

Before presenting a BMC as complete:
- [ ] Every block has at least one entry (none left blank)
- [ ] Value Proposition uses the "We help [X] [do Y] by [Z], unlike [alternative]" format
- [ ] Revenue Streams match what customers said they would pay for (cited research or test)
- [ ] Unit economics filled in (even rough estimates with assumptions stated)
- [ ] Riskiest assumptions identified and listed separately
- [ ] At least one "what would kill this model" scenario documented

## The 9 Blocks

```
┌───────────────┬──────────────────┬──────────────┬───────────────┬──────────────────┐
│ Key Partners  │ Key Activities   │              │ Customer      │ Customer         │
│               │                  │ Value        │ Relationships │ Segments         │
├───────────────┤                  │ Propositions │               │                  │
│ Key Resources │                  │              ├───────────────┤                  │
│               ├──────────────────┤              │ Channels      │                  │
│               │                  │              │               │                  │
├───────────────┴──────────────────┴──────────────┴───────────────┴──────────────────┤
│ Cost Structure                                  │ Revenue Streams                   │
└─────────────────────────────────────────────────┴───────────────────────────────────┘
```

---

### 1. Customer Segments
*Who are we creating value for? Who are our most important customers?*

- Mass market (one segment, large audience)
- Niche market (very specific segment)
- Segmented (multiple distinct segments with different needs)
- Multi-sided platform (two interdependent segments — e.g., buyers + sellers)

Questions:
- Who exactly is the customer?
- What are their demographics, behaviors, and pain points?
- Are there different types of customers with different needs?

---

### 2. Value Propositions
*What value do we deliver? Which problem do we solve? What need do we satisfy?*

Types of value:
- **Newness:** solves a problem no one solved before
- **Performance:** does something better than existing solutions
- **Customization:** tailored for a specific segment
- **Getting the job done:** helps customers complete a task
- **Price:** same or better value at lower cost
- **Risk reduction:** reduces risk for the customer
- **Convenience / accessibility:** makes something easier or more accessible

Template: "We help [customer segment] [do job / solve problem] by [unique mechanism], unlike [alternative] which [limitation]."

---

### 3. Channels
*How do we reach customers? How do we deliver value?*

- **Owned:** website, app, sales team, physical store
- **Partner:** resellers, distributors, affiliates
- **Digital:** SEO, social, paid ads, email, content marketing
- **Community:** word-of-mouth, ambassador programs

Channel phases: Awareness → Evaluation → Purchase → Delivery → After-sales

---

### 4. Customer Relationships
*What type of relationship do we establish with each segment?*

- Personal assistance (dedicated account manager)
- Self-service (customer handles everything)
- Automated services (personalized automated interactions)
- Communities (user forums, peer networks)
- Co-creation (customers co-build value — e.g., reviews, UGC)

---

### 5. Revenue Streams
*For what value are customers willing to pay? How do they currently pay?*

| Model | Example |
|-------|---------|
| Asset sale | One-time purchase (software license, product) |
| Usage fee | Pay per use (API calls, storage) |
| Subscription | Recurring fee (SaaS, streaming) |
| Freemium | Free base + paid premium tiers |
| Transaction fee | % of each transaction (marketplace, payment) |
| Licensing | IP license fee |
| Advertising | Charge advertisers, users are the product |

---

### 6. Key Resources
*What assets do we need to deliver value?*

- Physical (servers, offices, equipment)
- Intellectual (IP, patents, data, brand)
- Human (engineers, sales, domain experts)
- Financial (credit, equity, cash reserves)

---

### 7. Key Activities
*What critical things do we need to do?*

- Production (build, manufacture)
- Problem-solving (consulting, SaaS support)
- Platform/network management (matchmaking, moderation)

---

### 8. Key Partnerships
*Who are our suppliers and partners? What activities do they handle?*

Types:
- Strategic alliances (non-competitors)
- Joint ventures (co-create value)
- Buyer-supplier relationships (optimized, reliable supply)

Why partner: acquire resources you don't have, reduce risk, extend distribution.

---

### 9. Cost Structure
*What are the most important costs in the business?*

- **Cost-driven:** minimize costs (budget airlines, discount retail)
- **Value-driven:** premium price, less cost-focused (luxury, consulting)

Fixed vs. variable. Which costs scale with growth? Which don't?

---

## Unit Economics

| Metric | What It Measures |
|--------|----------------|
| CAC (Customer Acquisition Cost) | Total sales + marketing spend ÷ new customers acquired |
| LTV (Lifetime Value) | Average revenue per customer × average customer lifetime |
| LTV:CAC | Ratio — should be >3:1 for healthy SaaS |
| Payback Period | Months to recover CAC — should be <12 months ideally |
| Gross Margin | Revenue - COGS ÷ Revenue — software: 70–90%, marketplace: 40–60% |
| Churn Rate | % customers lost per month — <2% monthly is good for B2B SaaS |

---

## Revenue Model Design Questions

1. What would customers pay for in our value prop?
2. What do competitors charge? Are we above, at, or below parity?
3. Is this a one-time or recurring value?
4. Should we charge the buyer, seller, or both? (marketplace question)
5. Does freemium make sense? If so, what's the trigger to upgrade?
