---
name: product-strategy
description: Load for product roadmap planning, PRD writing, feature prioritization, OKR alignment, and product-market fit validation. Useful for PMs, founders, and FDEs building products.
---

# Product Strategy

## Product Strategy vs. Product Roadmap

**Strategy:** Why we're building what we're building. The bets we're making.  
**Roadmap:** When we're building what. The execution plan.

Strategy must come first. A roadmap without strategy is just a to-do list.

---

## Product-Market Fit (PMF)

**The only metric that matters before PMF:** retention.

PMF signals:
- Users come back without you prompting them
- Word-of-mouth is happening organically
- The "very disappointed" cohort (Sean Ellis test) is ≥40%
- Sales cycle shortens because the problem is obvious

Before PMF: do fewer things, talk to more users, ship faster cycles.  
After PMF: invest in scalability, team, and channels.

---

## PRD Template (Product Requirements Document)

```markdown
## Problem Statement
[1 paragraph: what problem, for whom, evidence it exists]

## Goals
- Business goal: [metric we want to move]
- User goal: [job the user is trying to get done]
- Non-goals: [what this explicitly doesn't solve]

## Background & Context
[Why now? What triggered this? What's the cost of not doing it?]

## User Stories
- As a [type of user], I want to [do something] so that [I get this outcome]

## Requirements
### Must Have (launch blockers)
- [ ] ...
### Should Have (important but not blocking)
- [ ] ...
### Won't Have (explicitly out of scope)
- [ ] ...

## Success Metrics
- Primary: [the one number that tells us this worked]
- Secondary: [supporting signals]
- Guardrails: [metrics we must not worsen]

## Open Questions
- [ ] [Question that needs to be answered before or during build]
```

---

## Roadmap Prioritization

### MoSCoW
- **Must:** launch blocker, revenue-critical, legally required
- **Should:** high value, not time-critical
- **Could:** nice to have, do if bandwidth allows
- **Won't:** explicitly out of scope for this cycle

### Opportunity Score (Ulwick)
```
Opportunity = Importance + max(Importance - Satisfaction, 0)
```
High importance + low satisfaction = biggest opportunity.

### Three Horizons
- **H1 (0–6 months):** core product, existing customers, revenue protection
- **H2 (6–18 months):** adjacent growth, new segments, capability building
- **H3 (18–36 months):** transformational bets, new markets, new business models

---

## OKR Alignment

Every product initiative should tie to an OKR:
```
Objective: [qualitative, inspiring direction]
Key Result 1: [measurable outcome by date]
Key Result 2: [measurable outcome by date]
Key Result 3: [measurable outcome by date]

Initiative: [what we're building]
→ Moves KR: [which key result and by how much]
```

If a feature doesn't tie to any OKR, question whether to build it.

---

## Discovery vs. Delivery Balance

| Mode | Focus | Output |
|------|-------|--------|
| Discovery | Is this the right thing to build? | Validated insight |
| Delivery | Are we building it right? | Working software |

Discovery is never done. Run discovery in parallel with delivery.  
If your team only ever delivers, you're accumulating assumption debt.

---

## User Interview Template

**Goal:** Understand the problem, not validate your solution.

```
1. Tell me about the last time you had to [do the job].
2. Walk me through what you did, step by step.
3. What was the hardest part?
4. What have you tried to solve it?
5. What did you wish existed?
```

Never pitch your solution during discovery. Listen 80%, talk 20%.
