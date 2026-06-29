---
name: solution-design
description: Forward Deployed Engineer (FDE) and solution engineering — translating client business problems into technical solutions, proposals, implementation scoping, and discovery workshops. Orchestrates business-analyst for requirements, architect (ECC agent) for system design, and data-analytics for evidence gathering. The FDE skill stack: business understanding + technical depth + executive communication.
---

# Solution Design (FDE / Solution Engineering)

## Skill Stack

- `business-analyst` agent — requirements elicitation, process mapping, gap analysis
- `architect` (ECC agent) — system design, API contracts, module boundaries
- `data-analytics` — when the solution involves data pipelines, reporting, or analytics
- `stakeholder-comms` — when the proposal goes to C-level or board
- `security-reviewer` (ECC agent) — before any solution involving user data, auth, or payments
- `market-research` — when the solution design needs to account for competitive context

## Guardrails

- Never propose a solution without completing discovery first — the presenting problem is rarely the actual problem
- A proposal without a "out of scope" section will be blamed for everything that goes wrong
- Define success criteria before scoping work — if you can't measure it, you can't prove you solved it
- The simplest solution that meets the requirements is always better than the elegant one
- Clients often ask for features; your job is to understand the underlying job they're trying to do

## What FDE Does

A Forward Deployed Engineer sits at the intersection of:
- **Business understanding:** knows the client's pain, their processes, their KPIs
- **Technical depth:** can design, build, and deploy the actual solution
- **Communication:** can talk to a CEO and an engineer in the same day

The FDE's job: go into a client's problem space, understand it deeply, and come out with a solution that actually works in their context.

---

## Discovery Framework

### Phase 1 — Problem Discovery (Before Any Solution)

**Business context questions:**
- What problem are you trying to solve, and what's the cost of not solving it?
- What does success look like in 6 months?
- Who is affected by this problem (end users, ops team, management)?
- What have you already tried? Why didn't it work?
- What are the constraints? (budget, timeline, existing systems, compliance)

**Technical context questions:**
- What systems are currently in place? (ERP, CRM, databases, APIs)
- Where does the data live? What format?
- What integrations are required?
- Who will maintain this after we build it?
- What's the security and compliance posture?

**Stakeholder mapping:**
```
Decision Maker:  [Who signs off]
Champion:        [Who wants this to succeed internally]
End Users:       [Who will use it daily]
Influencers:     [Who can block or accelerate]
Skeptics:        [Who needs convincing — and why]
```

---

## Solution Design Process

```
1. Discovery      → Understand the problem deeply
2. Root Cause     → Don't solve symptoms, solve the underlying issue
3. Solution Space → Explore 2–3 approaches before committing
4. Trade-off      → Analyze each option (cost, time, risk, fit)
5. Recommend      → Propose the best fit with clear reasoning
6. Validate       → Prototype / POC to confirm assumptions
7. Build          → Phased implementation with clear milestones
8. Measure        → Define KPIs upfront, track after launch
```

---

## Solution Options Analysis

For each option, document:

```
Option: [Name]
Description: [What it is in plain English]
How it works: [Technical approach]

Pros:
- [Advantage 1]
- [Advantage 2]

Cons:
- [Limitation 1]
- [Limitation 2]

Estimated Cost: [rough range]
Estimated Timeline: [rough range]
Risk Level: [Low / Medium / High]
Best when: [context where this option wins]
```

---

## Technical Proposal Template

```markdown
## Executive Summary
[2–3 sentences: what you're proposing and why it solves the client's problem]

## Problem Statement
[Description of the client's current state and pain points]

## Proposed Solution
[High-level description of the solution]

## Architecture Overview
[Diagram or description of system components]

## Scope of Work
### Phase 1 — [Name] ([timeline])
- [ ] Deliverable 1
- [ ] Deliverable 2

### Phase 2 — [Name] ([timeline])
- [ ] Deliverable 3

## Out of Scope
- [What we're explicitly NOT delivering]

## Technical Requirements
- [System requirements, integrations needed]

## Success Criteria
- [How we'll know this worked — measurable KPIs]

## Risks and Mitigations
| Risk | Probability | Impact | Mitigation |
|------|-------------|--------|------------|
| [Risk] | H/M/L | H/M/L | [Plan] |

## Investment
[Pricing breakdown by phase or milestone]

## Timeline
[Visual or table — key milestones and dates]

## Team
[Who's on the engagement and their roles]

## Next Steps
1. [Action] — [Owner] — [By when]
```

---

## Discovery Workshop Agenda (Half-Day)

```
[0:00]  Introductions and ground rules (10 min)
[0:10]  Current state walk-through — client presents their workflow (30 min)
[0:40]  Pain points deep dive — structured questioning (30 min)
[1:10]  Break (10 min)
[1:20]  Ideal future state — what would great look like? (30 min)
[1:50]  Solution space exploration — what approaches exist? (30 min)
[2:20]  Prioritize: what's most valuable, most feasible? (20 min)
[2:40]  Next steps and owners (10 min)
[2:50]  Close
```

---

## FDE Principles

1. **Understand before you prescribe.** Never propose a solution before finishing discovery.
2. **Build the simplest thing that works.** Complexity is a liability in enterprise software.
3. **Define success upfront.** If you can't measure it, you can't prove you solved it.
4. **Make clients self-sufficient.** Document, train, handoff. A good FDE doesn't create dependency.
5. **Speak both languages.** Translate technical constraints into business language. Translate business requirements into technical specs.
