---
description: Design a complete AI agent blueprint — goal, memory, tools, planning pattern, model selection, and evaluation criteria. Produces a ready-to-implement specification before writing any code.
---

Load the `agent-architecture` and `model-selection` skills. Activate the `automation-architect` agent.

Design a complete agent blueprint. Answer these questions in order before producing the spec:

1. What is the agent's single, specific goal? (If it has two goals, it needs two agents)
2. What data/APIs does it need to access?
3. Does it need to remember information across sessions?
4. How often does it run? (real-time / scheduled / on-demand)
5. What are the irreversible actions? (send email, post, charge, delete)

Then deliver:

**Agent Specification:**

```
AGENT BLUEPRINT
════════════════

NAME: [descriptive name]
GOAL: [one sentence, specific and measurable]

BRAIN
• Model: [model] — rationale: [why this one]
• System prompt:
  [full system prompt — role, capabilities, rules, output format]

MEMORY
• Type: [none / buffer / summary / vector store]
• Why: [rationale for this choice]
• Retention: [how long / how much]

TOOLS (minimum set)
• [tool_name]: [what it does, what it returns]
  Input schema: {field: type, description}
• [tool_name]: [purpose]
  Input schema: {field: type, description}

PLANNING PATTERN
• [ReAct / Plan-Execute / Reflexion] — [why]
• Max iterations: [N] — stop condition: [what triggers completion]
• Human checkpoints: [before which actions]

ERROR HANDLING
• Tool failure: [retry / skip / alert human / stop]
• LLM failure: [retry with backoff / fallback model / alert]
• Max retries: [N]

EVALUATION CRITERIA
• Success: [specific measurable outcome]
• Quality score: [what a "good" output looks like]
• Acceptable latency: [Xs]
• Acceptable cost: [$X per run]

TEST CASES
1. Happy path: [input → expected output]
2. Edge case: [empty input / missing data]
3. Failure case: [tool fails → expected behavior]
```

Apply Mode 1 and 4 of `agent-architecture` for the full anatomy and tool design patterns.
Calculate monthly cost using Mode 2 of `model-selection` at the expected volume.
