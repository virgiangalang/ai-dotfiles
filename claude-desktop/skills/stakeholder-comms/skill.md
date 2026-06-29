---
name: stakeholder-comms
description: Executive briefings, board updates, investor updates, status reports, and change management communication. Pairs with data-analytics when metrics need to be included, and marketing-campaign (ECC) when external communication is involved. For CEOs, PMs, FDEs, and consultants communicating at executive level.
---

# Stakeholder Communication

## Skill Stack

- `data-analytics` — when the brief must include metrics, trends, or data-backed findings
- `marketing-campaign` (ECC) — when communication is external (press, customer, public)
- `business-strategy` — when the communication involves strategic decisions or direction changes
- `pitch-deck` — when the communication is to investors or requires a presentation format

## Guardrails

- The audience's job determines the format — a board member and an engineer need different documents from the same situation
- Lead with the decision needed, not the background — executives read the first paragraph and skim the rest
- Bad news must be communicated directly — burying difficult information destroys trust when reality surfaces
- Every status report must have: owner, date, clear next step — three fields that prevent ambiguity
- Never use passive voice to avoid accountability ("it was decided" → "I decided" / "[Name] decided")

## The Core Rule

**Write for the reader's job, not yours.**

An engineer wants detail. A CEO wants: what happened, why it matters, what we're doing about it.  
Know your audience before you write a single word.

---

## Communication by Audience

| Audience | What They Care About | Format |
|----------|---------------------|--------|
| CEO / Executive | Bottom line, risk, competitive impact | 1-page brief, bullet summary |
| Board | Governance, KPIs, strategic risks | Board deck (structured, metrics-first) |
| Investors | ARR, burn, growth, hiring | Monthly/quarterly investor update |
| Product team | Requirements, priorities, tradeoffs | PRD, roadmap, meeting notes |
| Engineering | Technical specs, constraints | Technical design doc |
| Customer | Value, trust, clarity | Email, changelog, release notes |
| Media / Public | Story, brand narrative | Press release, blog post |

---

## Executive One-Pager Template

```
SUBJECT: [Topic] — [Date]

SITUATION
[2–3 sentences: what's happening and why it matters now]

KEY DECISIONS NEEDED
1. [Decision A] — options: [X / Y / Z], recommendation: [X]
2. [Decision B] — options: [X / Y], recommendation: [Y]

STATUS OF KEY METRICS
• [Metric 1]: [number] ([trend: ↑↓→])
• [Metric 2]: [number] ([trend])
• [Metric 3]: [number] ([trend])

TOP RISKS
1. [Risk] — Mitigation: [what we're doing]
2. [Risk] — Mitigation: [what we're doing]

NEXT STEPS
• [Action] — Owner: [Name] — Due: [Date]
• [Action] — Owner: [Name] — Due: [Date]
```

---

## Board Update Structure

1. **Executive Summary** — one paragraph: where are we vs. where we said we'd be?
2. **KPI Dashboard** — the 5–7 metrics that define company health
3. **Business Highlights** — 3–5 bullets of what went well
4. **Challenges** — honest about what isn't working, with mitigation plans
5. **Strategic Discussion** — 1–2 topics you need board input on
6. **Financials** — P&L, burn, runway, forecast
7. **Next Period Priorities** — what we're focused on

---

## Investor Update (Monthly)

```
MONTH: [Month Year]

HIGHLIGHTS
• [Win 1]
• [Win 2]
• [Win 3]

METRICS
• MRR: $X (↑Y% MoM)
• Active Users: X (↑Y% MoM)
• Churn: X%
• Runway: X months

CHALLENGES
• [Challenge] — what we're doing about it

WHAT I NEED FROM YOU
• [Specific ask — intro to X / advice on Y / etc.]

NEXT MONTH FOCUS
• [Priority 1]
• [Priority 2]
```

Short, honest, consistent. Monthly. Even when things are bad — especially when things are bad.

---

## Change Communication (For Org Changes, Pivots, Resets)

Structure: Context → Decision → Rationale → Impact → What's Next

```
WHAT IS CHANGING AND WHEN
[Clear, direct statement of the change]

WHY
[Honest business context — be direct, don't over-spin]

WHAT THIS MEANS FOR YOU
[Role-specific impact — be specific, not generic]

WHAT STAYS THE SAME
[Anchors people during uncertainty]

WHAT HAPPENS NEXT
[Timeline, process, who to go to with questions]

QUESTIONS
[Announce how/when people can ask — town hall, Slack, etc.]
```

Avoid: passive voice, vague language ("some changes"), burying the news.

---

## Status Update Template (Weekly / Project)

```
Project: [Name]
Week: [Date range]
Owner: [Name]

🟢 ON TRACK
• [What's going well]

🟡 AT RISK
• [What needs attention] — [mitigation]

🔴 BLOCKED
• [Blocker] — Need: [what you need to unblock]

COMPLETED THIS WEEK
• [ ] ...

NEXT WEEK
• [ ] ...

KEY METRICS
• [Metric]: [number]
```

---

## Communication Anti-Patterns to Avoid

| Anti-Pattern | Why It Fails |
|-------------|-------------|
| Burying the lede | Executives stop reading after 3 sentences |
| All detail, no summary | Forces the reader to extract your point for you |
| Only good news | Destroys trust when reality hits |
| Action items without owners and dates | Nothing gets done |
| Jargon without translation | Alienates non-technical stakeholders |
| Passive voice ("it was decided that...") | Lacks accountability |
| Sending without a clear ask | Leaves the reader wondering what to do |
