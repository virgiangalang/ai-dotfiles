---
description: Generate a visualization brief and complete Python/Power BI code for any data. Selects the right chart type, produces publication-quality output with insight-first title, and includes design rationale.
---

Load the `data-visualization` skill. Activate the `data-viz-expert` agent.

Create a complete visualization. Before writing code, answer:
1. What relationship am I showing? (comparison / trend / distribution / correlation / composition)
2. Who is the audience? (executive dashboard / analyst / public)
3. What is the ONE insight the viewer must take away?

Then deliver:

**Chart Selection**
Apply the Chart Selection Framework from `data-visualization`.
State which chart type and why — what makes it the right choice for this data relationship.

**Complete Python Code**
Use the professional style setup from Mode 1 of `data-visualization`.
Include:
- Full matplotlib/seaborn code (ready to run, not pseudocode)
- Insight-first title (states the finding, not the subject)
- Axis labels with units
- Color used for meaning (one highlight color)
- Save to file: `plt.savefig('chart.png', dpi=150, bbox_inches='tight')`

**If Plotly requested:**
Use Mode 2 — interactive version with hover data, consistent color palette.

**If Power BI requested:**
Use Mode 3 — specify the visual type, DAX measure if needed, and slicer configuration.

**Design Notes**
Explain: what is highlighted and why, what was removed and why, what color encodes.

Produce 2 variants if the best chart type is not obvious — let the user choose.
