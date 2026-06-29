---
name: product-roadmap
description: Generate a prioritized product roadmap from a list of ideas, initiatives, or requirements. Ask for context, score with RICE, and produce a Now/Next/Later structured roadmap with OKR alignment.
---

# /product-roadmap

Ask:
1. What is the product?
2. What's the team size and capacity?
3. What are the OKRs for this period?
4. What initiatives or features are you considering?
5. What's the time horizon? (Quarter / 6 months / Year)

Then produce:

```markdown
# Product Roadmap: [Product Name]
Period: [Q / H1 / Year] | Team size: [N] | Last updated: [Date]

## OKR Alignment
This roadmap is designed to deliver:
- OKR 1: [Objective] → KR: [Key Result]
- OKR 2: [Objective] → KR: [Key Result]

---

## RICE Scoring
| Initiative | Reach | Impact | Confidence | Effort | Score | OKR Link |
|-----------|-------|--------|------------|--------|-------|---------|
| [A] | | | | | | |
| [B] | | | | | | |
| [C] | | | | | | |

---

## Roadmap

### 🟢 NOW (This Quarter)
*Committed work — high confidence, in sprint*

| Initiative | Owner | Outcome | KR impact |
|-----------|-------|---------|----------|
| [A] | | [what user can do / metric it moves] | KR X |
| [B] | | | KR Y |

### 🔵 NEXT (Next Quarter)
*Planned — directionally committed, details TBD*

| Initiative | Rationale | Dependency |
|-----------|-----------|-----------|
| [C] | | |
| [D] | | |

### ⚪ LATER (Backlog / Future)
*Not committed — will revisit next planning cycle*

| Initiative | Why Later | Trigger to Promote |
|-----------|-----------|-------------------|
| [E] | | |
| [F] | | |

---

## Explicitly NOT Doing This Period
| Initiative | Why Not |
|-----------|---------|
| [G] | [reason — not because we forgot, but because we chose] |

---

## Key Milestones
| Date | Milestone | Success Signal |
|------|-----------|---------------|
| [Date] | [Milestone] | [How we know it's done] |

---

## Open Dependencies & Risks
- [Dependency on team X / vendor Y / decision Z]
- [Risk: if [thing] happens, [initiative] is affected]
```
