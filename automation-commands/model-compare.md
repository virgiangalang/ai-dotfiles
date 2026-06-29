---
description: Compare AI models for a specific use case. Evaluates quality, cost at volume, speed, context window, and special capabilities. Delivers a clear recommendation with monthly cost projection.
---

Load the `model-selection` skill. Activate the `model-advisor` agent.

Compare AI models for the described use case. Gather:
1. What task will the model perform?
2. Expected monthly volume (requests or tokens)
3. Quality bar (what does a good output look like?)
4. Latency requirement (real-time / batch OK?)
5. Any special needs (multilingual / vision / long context / tool use / structured output)?
6. Monthly budget cap (if any)?

Then deliver:

**Comparison Table**
Using the Model Comparison Matrix from `model-selection`:
- Select 3-4 candidate models appropriate for this use case
- Show: quality rating, input cost, output cost, context window, key strength/weakness

**Cost Projection**
Run the cost calculator from Mode 2 of `model-selection` for each model at stated volume.
Show: cost per request, monthly cost, annual cost.

**Quality Assessment**
For the top 2 models: describe specifically how they would perform on this task (not general benchmarks — task-specific assessment).

**Recommendation**
- Primary recommendation with rationale
- When to use the backup option
- Hybrid strategy if applicable (e.g., 80% Haiku + 20% Sonnet)

**Open Source Option**
Evaluate if any open source model (Llama, Mistral, DeepSeek, Qwen) fits the use case.
If yes: include hosting cost estimate and breakeven vs. API.

**Fine-Tuning Assessment**
Apply the fine-tuning decision framework from Mode 5 of `model-selection`.
Should this use case use a fine-tuned model instead of a base model?

Note: All pricing is approximate. Verify at provider's current pricing page before committing.
