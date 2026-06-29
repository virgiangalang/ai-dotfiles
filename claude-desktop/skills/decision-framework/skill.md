---
name: decision-framework
description: Structured decision-making for complex choices — RICE, decision matrix, pre-mortem, first principles, reversibility analysis. Works with business-strategy for strategic decisions, product-strategy for product tradeoffs, and okr-planning for resource allocation decisions.
---

# Decision Frameworks

## Skill Stack

- `business-strategy` — when the decision is about market entry, competitive response, or resource allocation
- `product-strategy` — when the decision is about what to build or prioritize
- `data-analytics` — when there is data that should inform the decision
- `okr-planning` — when the decision affects team priorities or OKR commitments

## Guardrails

- Irreversible decisions deserve structured analysis; reversible decisions favor speed over process
- A decision matrix with invented weights produces false precision — establish weights based on actual business constraints
- The pre-mortem is not optional for decisions >$50K, >3 months of team time, or that affect customers directly
- Document every decision with reasoning — the decision log prevents relitigating settled choices
- "We'll figure it out later" is a decision — treat it as one

## Step 0 — Define the Decision

Before picking a framework, get clear on:
- What exactly is the decision? (Be specific)
- Who needs to decide? (1 person, team, board?)
- What's the deadline?
- Is this reversible or not? (This determines how much analysis to do)

**Reversible decisions:** bias toward speed. Make the call, learn, adjust.
**Irreversible decisions:** slow down. Use structured frameworks. Get more input.

## Framework Selection

| Situation | Use |
|-----------|-----|
| Prioritizing features/initiatives | RICE or ICE |
| Choosing between 2-5 options | Decision Matrix |
| High-stakes strategic choice | Pre-mortem + First Principles |
| Feature vs. not | Opportunity Score |
| Resource allocation | Effort vs. Impact Matrix |

---

## RICE Scoring (Feature / Initiative Prioritization)

```
Score = (Reach × Impact × Confidence) / Effort

Reach:      How many users/customers affected? (per quarter)
Impact:     How much does it move the metric? (0.25 / 0.5 / 1 / 2 / 3)
Confidence: How sure are we? (50% / 80% / 100%)
Effort:     Person-months of work
```
Higher score = higher priority. Always stack-rank, never prioritize in isolation.

## ICE Scoring (Quick Prioritization)

```
Score = Impact + Confidence + Ease (each 1–10)
```
Faster than RICE. Good for early-stage when data is sparse.

## Decision Matrix (Choosing Between Options)

1. List criteria that matter (e.g., cost, time, risk, scalability, team fit)
2. Assign weights to each criterion (total = 100%)
3. Score each option per criterion (1–5)
4. Multiply score × weight, sum per option
5. Highest total wins — but gut-check the result

```
             Weight  Option A  Option B  Option C
Cost           30%      4        2         3
Speed          25%      3        5         2
Risk           20%      5        3         4
Scalability    15%      2        4         5
Team Fit       10%      5        3         4
─────────────────────────────────────────────
Weighted Total         3.55     3.30      3.35
```

## Pre-Mortem (Stress Test Before Committing)

Before executing a decision, run this:
1. Imagine it's 12 months later. The decision failed catastrophically.
2. What went wrong? (brainstorm without editing — 5-10 reasons)
3. Which failure modes are preventable? Build mitigations now.
4. Which are acceptable risks? Accept them consciously.

## First Principles (When You're Stuck in Assumptions)

1. State the problem
2. Ask: what do we think is true about this problem?
3. For each assumption, ask: is this actually true, or is it inherited wisdom?
4. Strip away everything that isn't a fundamental fact
5. Rebuild reasoning from the ground up

## Effort vs. Impact Matrix

```
           Low Effort    High Effort
High Impact   QUICK WINS    BIG BETS
Low Impact    FILL-INS      AVOID
```
Quick Wins first. Big Bets need resourcing + sequencing. Fill-Ins when capacity exists. Avoid the bottom-right.

## Decision Log Template

```
Decision: [what was decided]
Date: [when]
Owner: [who made the call]
Context: [why this decision was needed now]
Options considered: [list with brief notes]
Why this option: [the reasoning]
Key risks accepted: [what could go wrong]
Review date: [when to revisit]
```

Keeping a decision log prevents revisiting settled choices and helps new team members understand why things are the way they are.
