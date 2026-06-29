---
name: jtbd
description: Run a Jobs-to-be-Done (JTBD) analysis for a product, feature, or customer segment. Identify the functional, emotional, and social jobs customers are hiring the product to do. Use for product discovery, marketing positioning, and feature prioritization.
---

# /jtbd

Ask: "What product or feature are you analyzing? Who is the customer?"

Then produce:

```markdown
# Jobs-to-be-Done Analysis: [Product / Feature]
Customer: [Segment] | Date: [Date]

---

## Context Setup
When does the customer encounter this job?
- Situation: [What triggers the need?]
- Frequency: [How often does this job arise?]
- Stakes: [What's the cost of doing this job poorly?]

---

## Job Mapping

### Functional Jobs (What they're trying to accomplish)
| Job Statement | Importance | Satisfaction with current solutions |
|--------------|------------|-----------------------------------|
| When [situation], I want to [action] so I can [outcome] | H/M/L | H/M/L |
| | | |
| | | |

**Highest opportunity** (high importance, low satisfaction):
→ [Job statement — this is where to focus]

### Emotional Jobs (How they want to feel)
- [I want to feel confident that...]
- [I want to avoid feeling...]
- [I want to feel in control of...]

### Social Jobs (How they want to be perceived)
- [I want my team / boss / customers to see me as...]
- [I don't want to be seen as...]

---

## Current Solutions (Real Competition)
| Current Solution | Why They Use It | Why It Falls Short |
|-----------------|----------------|-------------------|
| [A] | | |
| [B] | | |

---

## Opportunity Score
```
Opportunity = Importance + (Importance - Satisfaction)
Score > 10 = significant opportunity
```
| Job | Importance | Satisfaction | Opportunity Score |
|-----|------------|-------------|------------------|
| [Job 1] | X | X | X |
| [Job 2] | X | X | X |

Top opportunity: [Job X] — Score: [X]

---

## Implications for Product

**What to build:** [Features that address the highest opportunity jobs]

**What to cut:** [Features that serve low-opportunity jobs]

**Positioning:** [How to communicate in terms of the job, not the feature]
Example headline: "[Do job outcome] without [biggest current friction]"

**Interview questions to validate:**
1. Tell me about the last time you had to [do the job].
2. What did you use to solve it? Walk me through step by step.
3. What was the hardest part?
4. What would make this perfect?
```
