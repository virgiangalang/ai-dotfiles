---
name: okr-workshop
description: Facilitate an OKR planning session. Ask for the team, time period, and company context, then guide through setting well-structured OKRs with quality checks built in.
---

# /okr-workshop

## Step 1 — Gather Context

Ask:
1. Which team / company level are these OKRs for?
2. What quarter/period?
3. What are the company-level OKRs (if setting team OKRs)?
4. What's the team's primary focus area?
5. What did you achieve / miss last quarter?

## Step 2 — Brainstorm (Prompt the User)

"Based on your context, here are potential focus areas for this quarter:
[Generate 5–8 candidate objectives based on input]

Which of these resonate? Or what else should we include?"

## Step 3 — Draft OKRs

For each Objective:
```
OBJECTIVE: [Qualitative, inspiring, time-bound]

Key Result 1: [Measurable, outcome-based] → Target: [X] by [date]
Key Result 2: [Measurable, outcome-based] → Target: [X] by [date]
Key Result 3: [Measurable, outcome-based] → Target: [X] by [date]

Owner: [Person responsible]
Company OKR alignment: [Which company OKR does this support?]
```

## Step 4 — Quality Check (Run Automatically)

For each KR, verify:
- [ ] Has a number (if not, flag and suggest how to make it measurable)
- [ ] Is an outcome, not a task (flag output KRs and suggest rewrites)
- [ ] Is ambitious but achievable (flag if trivially easy or unrealistic)
- [ ] Has a clear owner
- [ ] Connects to a company OKR

## Step 5 — Final OKR Set

Produce the clean, validated OKR set:
```
TEAM: [Name] | PERIOD: [Q]

O1: [Objective]
  KR1: [result] → [target]
  KR2: [result] → [target]
  KR3: [result] → [target]

O2: [Objective]
  ...

CHECK-IN SCHEDULE:
Week 2: First status check
Week 6: Mid-quarter review  
Week 12: End-of-quarter scoring + retrospective
```
