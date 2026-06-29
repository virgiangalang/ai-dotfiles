---
description: Analyze, rewrite, and optimize a SQL query for readability and performance. Converts subqueries to CTEs, adds window functions where appropriate, identifies missing indexes, and estimates performance improvement.
---

Load the `sql-analytics` skill. Activate the `sql-analyst` agent.

Optimize the provided SQL query. Deliver:

**1. Plain English Translation**
What does this query currently do? Explain in 3-5 sentences without using SQL terms.

**2. Issues Found**
Check for:
- `SELECT *` → replace with explicit columns
- Nested subqueries → convert to CTEs
- Missing JOIN type → add explicit INNER/LEFT/etc.
- Functions on indexed columns in WHERE clause (prevents index use)
- DISTINCT used to mask a join problem
- Window function that could replace a self-join
- Missing NULLIF() where division could divide by zero
- Repeated subquery that could be a CTE

**3. Rewritten Query**
Apply Mode 2 of `sql-analytics` (CTE pattern):
- One CTE per logical step
- Each CTE named by its job (not `cte1`, `cte2`)
- Explicit column names
- Proper JOIN types
- Comments on non-obvious logic

**4. Performance Analysis**
- Which columns should be indexed?
- For BigQuery: does it prune partitions efficiently?
- For Snowflake: is clustering key used?
- Estimated rows at each step (helps catch cartesian join)
- Recommend: run EXPLAIN ANALYZE on the rewritten version

**5. Before/After Comparison**
```
BEFORE: [N] lines, [issues found]
AFTER:  [N] lines, [issues resolved]
Expected improvement: [estimation]
```

Ask for the database type (BigQuery / Snowflake / PostgreSQL / MySQL) before starting — optimization differs by platform.
