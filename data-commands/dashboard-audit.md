---
description: Audit an existing dashboard (Power BI, Tableau, Streamlit, or Looker) for design quality, data accuracy, and business usefulness. Delivers a prioritized fix list with specific rewrites.
---

Load the `data-visualization` and `power-bi` skills. Activate the `data-viz-expert` agent.

Audit the provided dashboard. Score and fix across 4 dimensions:

**1. Design Quality**
Check each visual:
- [ ] Chart type appropriate for data relationship?
- [ ] 3D charts present? (CRITICAL — must remove)
- [ ] Pie charts with >5 slices? (HIGH — convert to bar)
- [ ] Axes labeled with units?
- [ ] Colors used for meaning, not decoration?
- [ ] Titles state the insight (not just the subject)?
- [ ] Max 7 visuals per page?
- [ ] Consistent font sizes and color palette?

**2. Data Accuracy**
- [ ] Are the metrics correctly calculated?
- [ ] Do filters affect all visuals as expected?
- [ ] Are date ranges clearly shown?
- [ ] Are KPI cards showing current vs. prior period comparison?
- [ ] Are totals matching (no double-counting)?

**3. Business Usefulness (5-second test)**
Can a new viewer understand the main insight within 5 seconds?
- What question does each page answer? Is it clearly stated in the title?
- Is the most important number the most visually prominent?
- Are the recommended actions obvious from the data?

**4. For Power BI specifically:**
- [ ] Data model is star schema?
- [ ] Calculated columns used instead of measures where measures would work?
- [ ] Time intelligence measures tested with date slicer?
- [ ] Row-level security configured where needed?
- [ ] Refresh schedule set up?

**Deliver:**
- CRITICAL issues (must fix — blocks understanding or shows wrong data)
- HIGH issues (should fix — affects usability)
- MEDIUM suggestions (nice to have)
- Specific rewrite for each CRITICAL/HIGH: what the title/DAX/chart should say/be instead
