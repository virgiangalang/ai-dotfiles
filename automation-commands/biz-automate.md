---
description: Design and build a complete business process automation — from process mapping to working N8N workflow or agent code. The end-to-end command for replacing manual work with AI agents.
---

Load the `business-automation`, `n8n-automation`, and `multi-agent-systems` skills. Activate the `automation-architect` agent.

Build a complete business automation. Gather this information first:
1. What is the process? (describe it step by step as a human would do it today)
2. What triggers it? (new email / schedule / form submission / app event)
3. What apps are involved? (CRM, email, Slack, spreadsheet, etc.)
4. What is the final output? (report sent, record created, message posted, etc.)
5. How many times per day/week does this run?
6. What goes wrong when done manually?

Then deliver the full automation:

**Process Map (current state)**
Draw the manual process:
```
Step 1: [who] does [what] using [tool] → output: [X]
Step 2: [who] does [what] → output: [X]
...
```
Total time per run: [X minutes]
Pain points: [errors, delays, missed steps]

**Automation Design**
Apply Mode 1 of `business-automation` (readiness scoring).
Recommended platform: N8N / LangGraph / CrewAI / Claude SDK — with rationale.

**N8N Workflow (if N8N is the right tool)**
Complete workflow map using Mode 2 of `n8n-automation`:
- Every node named and configured
- Error handler included
- Test instructions

**Agent Code (if code is the right tool)**
Complete Python implementation using Mode 3 of `multi-agent-systems` (Claude SDK pattern):
- Tool definitions
- Agent logic
- Error handling
- Cost logging

**ROI Summary**
```
Before: [X hours/month] × [$Y/hr] = $[Z]/month
After:  $[AI cost + hosting]/month
Savings: $[Z]/month → $[Z×12]/year
Payback: [N weeks]
```

**Go-Live Checklist**
- [ ] Tested with 10 real examples
- [ ] Error handler configured
- [ ] Human review enabled for first 2 weeks
- [ ] Monitoring / alerting set up
- [ ] Manual override documented
- [ ] Team trained on what to do if automation fails
