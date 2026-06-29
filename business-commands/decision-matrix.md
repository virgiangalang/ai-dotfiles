---
name: decision-matrix
description: Structure and evaluate a complex decision using a weighted decision matrix. Ask for the options and criteria, then score and recommend with clear reasoning.
---

# /decision-matrix

## Step 1 — Gather Input

Ask:
1. What decision are you making?
2. What are the options you're considering?
3. What criteria matter for this decision?
4. Is this reversible or irreversible?
5. Who needs to sign off?

## Step 2 — Generate Matrix

```markdown
# Decision Matrix: [Decision Title]
Date: [Date] | Owner: [Name] | Reversible: [Yes/No]

## Options
1. [Option A]
2. [Option B]  
3. [Option C]

## Criteria & Weights
| Criteria | Weight | Why It Matters |
|----------|--------|---------------|
| [Criteria 1] | X% | [reason] |
| [Criteria 2] | X% | [reason] |
| [Criteria 3] | X% | [reason] |
| [Criteria 4] | X% | [reason] |
Total: 100%

## Scoring (1 = Poor, 5 = Excellent)
| Criteria | Weight | Option A | Option B | Option C |
|----------|--------|----------|----------|----------|
| [C1] | X% | [score] | [score] | [score] |
| [C2] | X% | [score] | [score] | [score] |
| [C3] | X% | [score] | [score] | [score] |
| [C4] | X% | [score] | [score] | [score] |
| **Weighted Total** | | **X.XX** | **X.XX** | **X.XX** |

## Analysis
**Winner by matrix:** [Option X]

**Gut-check:** Does this feel right? [If the winner surprises you, investigate why]

**Key tradeoffs:**
- Choosing [A] means giving up [B's advantage]
- Choosing [B] optimizes for [criteria] at the cost of [other criteria]

## Recommendation
**Recommended:** [Option X]

**Reasoning:** [2–3 sentences on why this is the best fit for the context]

**Conditions:** [What would change this recommendation?]

**Next step:** [Who needs to approve this? By when?]
```

## Step 3 — Pre-Mortem (For Irreversible Decisions)

"Before committing, let's stress test this. Imagine it's 12 months from now and [chosen option] failed badly. What went wrong?"

[Generate 5 plausible failure modes based on the option's weaknesses]

For each: is this preventable? If yes, what's the mitigation?
