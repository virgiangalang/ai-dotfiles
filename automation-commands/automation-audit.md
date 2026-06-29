---
description: Audit a business or department for automation opportunities. Maps current manual processes, scores each for automation readiness, calculates ROI, and delivers a prioritized automation roadmap.
---

Load the `business-automation` skill. Activate the `automation-architect` agent.

Conduct a full automation opportunity audit. Ask for:
- Department or business area to audit (Marketing / Sales / Ops / Finance / HR / Support / All)
- Team size and approximate hourly cost
- Current tools and apps in use

Then deliver:

**1. Process Inventory**
List every repeating process in the department. For each:
- Name and description
- Frequency (daily / weekly / monthly)
- Time per execution (hours)
- Who does it (role / cost)
- Tools involved

**2. Automation Readiness Scoring**
Score each process on the 5-dimension framework from `business-automation` Mode 1:
1. Repetitive (1-5)
2. Rule-based (1-5)
3. Data-driven (1-5)
4. Volume (1-5)
5. Time-sensitive (1-5)

Total ≥ 15 → automate fully | 10-14 → automate with review | <10 → assist only

**3. ROI Calculation**
For each automation candidate, calculate using the formula from `business-automation` Mode 4:
- Current monthly cost (hours × rate)
- Estimated AI + hosting cost
- Monthly savings
- Annual ROI %

**4. Prioritized Roadmap**
Rank by: (ROI × ease of implementation). Deliver:
- Week 1-2: Quick wins (highest ROI, easiest to build)
- Month 1: Core process automation
- Month 2-3: Advanced / dependent processes
- Month 6: Full department coverage

**5. Agent Team Design**
For top 3 automation targets: propose the agent team using Mode 2 of `business-automation`.
Specify: tool, model, trigger, and integration for each agent.

**6. Risk Assessment**
For each proposed automation:
- What breaks if the automation fails?
- What's the manual override?
- Which actions need human approval?
