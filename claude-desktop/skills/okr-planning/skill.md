---
name: okr-planning
description: OKR design, cascade, and quarterly review for company, team, and individual levels. Pairs with product-strategy to align roadmap initiatives to OKRs, data-analytics to validate KR baselines and targets, and decision-framework for resource allocation decisions. Includes workshop agenda, scoring system, and quality gate.
---

# OKR Planning

## Skill Stack

- `product-strategy` — align roadmap initiatives to OKRs before committing to build
- `data-analytics` — validate current-state baselines and set realistic but ambitious KR targets from data
- `decision-framework` — RICE scoring and effort-vs-impact matrix for prioritizing initiatives that feed OKRs
- `business-strategy` — when OKRs need to align to a multi-year strategic direction or market bet
- `stakeholder-comms` — OKR presentations to board, investors, or all-hands

## Guardrails

- Do not set KRs that are output-based ("ship feature X") — rewrite as outcomes ("increase metric Y by Z%")
- Every KR must have a baseline value known at the time of setting — no KRs without current-state data
- Max 3 Objectives per team, max 3 KRs per Objective — more means nothing is actually a priority
- 100% attainment is a red flag — KRs should be set so that 70% feels like a real win
- OKRs are not a performance review tool — never tie individual compensation directly to OKR scores
- Run `data-analytics` before setting any KR target — targets set without data are guesses, not goals

## What OKRs Are (and Aren't)

**OKRs are:** a shared language for priorities and outcomes.  
**OKRs are not:** a performance review tool, a task list, or a roadmap.

If OKRs become a checkbox exercise, they've failed. The goal is alignment and focus — everyone pulling in the same direction.

---

## Anatomy of a Good OKR

```
OBJECTIVE: [Qualitative, inspiring, time-bound direction]
  Key Result 1: [Measurable, specific, ambitious outcome]
  Key Result 2: [Measurable, specific, ambitious outcome]
  Key Result 3: [Measurable, specific, ambitious outcome]
```

**Objective checklist:**
- [ ] Qualitative and memorable (not a number)
- [ ] Clearly achievable within the OKR period
- [ ] Inspiring — would a team member feel energized by it?

**Key Result checklist:**
- [ ] Measurable (has a number)
- [ ] Outcome-based, not output-based ("revenue ↑ 20%" not "ship feature X")
- [ ] Ambitious but not impossible (70% attainment = good)
- [ ] Max 3 per Objective
- [ ] Tells you, unambiguously, whether the Objective was achieved

---

## Company → Team → Individual Cascade

```
Company OKR
├── Team A OKR (contributes to Company KR1)
│   └── Individual OKR (contributes to Team KR2)
└── Team B OKR (contributes to Company KR2)
```

Each team's Objectives should explain how they're contributing to company OKRs.  
Don't cascade outputs (tasks). Cascade outcomes (results).

---

## OKR Examples

### CEO / Company Level
```
O: Become the market leader in SME accounting software in Southeast Asia
  KR1: Reach 10,000 paying customers by Q4
  KR2: Achieve NPS of 60+
  KR3: Expand to 3 new countries (Philippines, Thailand, Malaysia)
```

### Product Team
```
O: Make onboarding so easy that customers activate without human support
  KR1: Reduce time-to-first-value from 14 days to 3 days
  KR2: Increase D7 retention from 40% to 60%
  KR3: Reduce onboarding support tickets by 50%
```

### Engineering Team
```
O: Build a platform that scales without breaking
  KR1: Achieve 99.9% uptime in Q3
  KR2: Reduce P1 incident resolution time from 4h to 1h
  KR3: Reduce deployment time from 45 min to 10 min
```

---

## Common OKR Mistakes

| Mistake | Fix |
|---------|-----|
| Output KRs ("ship X feature") | Rewrite as outcomes ("increase Y metric by Z%") |
| Too many OKRs (>5 objectives, >5 KRs each) | Cut ruthlessly. Focus is the point. |
| OKRs set top-down only | Mix top-down (company) with bottom-up (team) |
| No check-ins | Weekly or biweekly progress review is mandatory |
| Sandbagging (setting easy KRs) | 70% attainment should feel like a good stretch |
| Treating OKRs as a performance review | Separate processes. OKRs are about the company, not the individual. |

---

## Check-In Cadence

| Cadence | What |
|---------|------|
| Weekly | Red/Yellow/Green status per KR. Blockers surfaced. |
| Monthly | Deeper review — what's on track, what needs replanning? |
| End of Quarter | Score each KR (0.0–1.0). Retrospective. |

### Scoring
- **0.0–0.3:** Failed. Did we have the wrong goal, or wrong execution?
- **0.4–0.6:** Partial. Understand why, capture learnings.
- **0.7–1.0:** Achieved. If consistently 1.0, KRs were too easy.

---

## OKR Workshop Agenda (2 hours)

```
[0:00] Context setting — company direction, last quarter review (15 min)
[0:15] Team brainstorm — what should we focus on this quarter? (20 min)
[0:35] Draft OKRs in small groups (30 min)
[1:05] Present drafts, discuss, challenge (25 min)
[1:30] Prioritize and finalize (20 min)
[1:50] Assign owners and next steps (10 min)
```
