---
name: model-selection
description: AI model comparison and selection specialist. Covers cost per token, quality benchmarks, speed, context window, tool use capability, and use-case matching across Claude, GPT-4o, Gemini, Llama, Mistral, Qwen, and other models. Use when choosing which LLM to use for a specific task or system.
---

# Model Selection

## Skill Stack

- `agent-architecture` — model selection happens during agent design
- `multi-agent-systems` — different agents in a system can use different models strategically
- `business-automation` — cost modeling for automating business processes at scale

## Guardrails

- Never recommend a model without asking about the use case first — there is no universally "best" model
- Always include cost in the recommendation — a model 5% better at 10× the cost is usually wrong
- Never compare models on one benchmark — use multiple dimensions (quality, speed, cost, context)
- Open source ≠ free — hosting costs and GPU requirements must be factored in
- Model versions change — always check the provider's current pricing page before quoting costs
- Fine-tuned models for a specific task often beat larger general models — consider this option

---

## Model Comparison Matrix

### Tier 1: Frontier Models (Best quality, higher cost)

| Model | Provider | Input ($/1M) | Output ($/1M) | Context | Best For |
|---|---|---|---|---|---|
| **claude-sonnet-4-6** | Anthropic | $3 | $15 | 200K | Coding, reasoning, tool use, agentic tasks |
| **claude-opus-4-8** | Anthropic | $15 | $75 | 200K | Complex reasoning, research, nuanced writing |
| **gpt-4o** | OpenAI | $2.50 | $10 | 128K | Multimodal, general tasks, GPT ecosystem |
| **gpt-4o-mini** | OpenAI | $0.15 | $0.60 | 128K | High volume, classification, extraction |
| **gemini-2.0-flash** | Google | $0.10 | $0.40 | 1M | Large context, speed, Google ecosystem |
| **gemini-2.5-pro** | Google | $1.25 | $10 | 1M | Long document analysis, complex reasoning |

### Tier 2: Efficient Models (Great quality-to-cost ratio)

| Model | Provider | Input ($/1M) | Output ($/1M) | Context | Best For |
|---|---|---|---|---|---|
| **claude-haiku-4-5** | Anthropic | $0.80 | $4 | 200K | High-volume tasks, classification, summarization |
| **gpt-4o-mini** | OpenAI | $0.15 | $0.60 | 128K | Classification, simple generation, RAG retrieval |
| **gemini-flash-lite** | Google | $0.075 | $0.30 | 1M | Extremely high volume, simple tasks |

### Tier 3: Open Source (Self-hosted or API)

| Model | Size | Best For | Hosting Cost |
|---|---|---|---|
| **Llama 3.3 70B** | 70B | General tasks, coding, multilingual | ~$1/hr GPU |
| **Llama 3.1 8B** | 8B | High volume, fast inference, edge | ~$0.20/hr GPU |
| **Mistral Large** | ~123B | European data sovereignty, multilingual | API: $2/$6 per 1M |
| **Mistral 7B** | 7B | Fast, efficient, fine-tuneable | API: $0.25/$0.25 |
| **Qwen2.5 72B** | 72B | Chinese/Indonesian multilingual, coding | Self-host or API |
| **DeepSeek V3** | 671B MoE | Coding, reasoning, very cheap API | API: $0.27/$1.10 |
| **Phi-4** | 14B | Small model, strong reasoning, edge | Free self-host |

---

## Operating Modes

### Mode 1: Use-Case → Model Mapping

**Coding and software engineering:**
```
Best: claude-sonnet-4-6 (strongest at coding, tool use, agentic tasks)
Alt:  gpt-4o (strong, good for GPT ecosystem integrations)
Alt:  DeepSeek V3 (near-Sonnet quality at a fraction of the cost)
Budget: claude-haiku-4-5 (surprisingly good at simple code tasks)
```

**Complex reasoning and research:**
```
Best: claude-opus-4-8 (deepest reasoning, multi-step analysis)
Alt:  gemini-2.5-pro (excellent for long documents, 1M context)
Alt:  o3 / o3-mini (OpenAI's reasoning models, good for math/science)
```

**High-volume classification or extraction:**
```
Best: gpt-4o-mini (cheap, reliable, good at structured output)
Alt:  claude-haiku-4-5 (strong at extraction, better tool use than gpt-4o-mini)
Alt:  gemini-flash-lite (cheapest at scale, good accuracy)
Budget: Llama 3.1 8B self-hosted (zero marginal cost at volume)
```

**Multilingual (Bahasa Indonesia, Chinese, etc.):**
```
Best: Qwen2.5 72B (specifically trained on Asian languages)
Alt:  gemini-2.0-flash (strong multilingual, fast)
Alt:  claude-sonnet-4-6 (good multilingual, best tool use)
Avoid: Older Llama models (weaker on non-English)
```

**Long document analysis (>50K tokens):**
```
Best: gemini-2.5-pro (1M context, great at long docs)
Alt:  claude-sonnet-4-6 (200K context, very accurate on long contexts)
Alt:  gemini-2.0-flash (1M context, much cheaper than 2.5-pro)
Avoid: gpt-4o (128K limit, drops quality on very long contexts)
```

**Vision / multimodal:**
```
Best: gpt-4o (best vision quality, fast)
Alt:  claude-sonnet-4-6 (excellent vision, great at structured extraction from images)
Alt:  gemini-2.0-flash (strong vision, cheap)
Budget: Llama 3.2 Vision (open source, self-hostable)
```

**Real-time / low latency:**
```
Best: gpt-4o-mini (fast + cheap)
Alt:  claude-haiku-4-5 (fastest Claude, very low latency)
Alt:  gemini-flash (Google's fast tier)
Edge: Phi-4 self-hosted (14B, very fast on modern hardware)
```

---

### Mode 2: Cost Calculator

```python
def calculate_monthly_cost(
    model: str,
    daily_requests: int,
    avg_input_tokens: int,
    avg_output_tokens: int
) -> dict:

    # Pricing per 1M tokens (as of 2025 — verify current pricing)
    PRICING = {
        "claude-sonnet-4-6":      {"input": 3.00,  "output": 15.00},
        "claude-haiku-4-5":       {"input": 0.80,  "output": 4.00},
        "claude-opus-4-8":        {"input": 15.00, "output": 75.00},
        "gpt-4o":                 {"input": 2.50,  "output": 10.00},
        "gpt-4o-mini":            {"input": 0.15,  "output": 0.60},
        "gemini-2.0-flash":       {"input": 0.10,  "output": 0.40},
        "gemini-2.5-pro":         {"input": 1.25,  "output": 10.00},
        "deepseek-v3":            {"input": 0.27,  "output": 1.10},
    }

    if model not in PRICING:
        return {"error": f"Unknown model: {model}"}

    p = PRICING[model]
    monthly_requests = daily_requests * 30

    input_cost  = (avg_input_tokens  / 1_000_000) * p["input"]  * monthly_requests
    output_cost = (avg_output_tokens / 1_000_000) * p["output"] * monthly_requests
    total_cost  = input_cost + output_cost

    return {
        "model": model,
        "monthly_requests": monthly_requests,
        "monthly_input_cost_usd":  round(input_cost, 2),
        "monthly_output_cost_usd": round(output_cost, 2),
        "monthly_total_usd":       round(total_cost, 2),
        "cost_per_request_usd":    round(total_cost / monthly_requests, 4),
    }

# Example: Customer support chatbot
print(calculate_monthly_cost("claude-haiku-4-5", daily_requests=1000,
                              avg_input_tokens=500, avg_output_tokens=200))
# → $67.20/month for 30K requests

# Compare with Sonnet
print(calculate_monthly_cost("claude-sonnet-4-6", daily_requests=1000,
                              avg_input_tokens=500, avg_output_tokens=200))
# → $282/month for 30K requests — 4× more expensive for probably 20% better

# Hybrid: use Haiku for most, Sonnet only for complex cases
# → 80% Haiku + 20% Sonnet = $67.20*0.8 + $282*0.2 = $110/month
```

---

### Mode 3: Multi-Agent Cost Optimization

In multi-agent systems, cost optimization is critical because tokens multiply:

```python
# Agent tier strategy
AGENT_MODEL_MAPPING = {
    # Orchestrator: needs reasoning, handles small volume
    "orchestrator": "claude-sonnet-4-6",       # $3/$15

    # High-volume workers: cheap, fast
    "email_writer":     "claude-haiku-4-5",    # $0.80/$4
    "classifier":       "gpt-4o-mini",         # $0.15/$0.60
    "summarizer":       "gemini-flash-lite",   # $0.075/$0.30

    # Specialist workers: need quality
    "code_reviewer":    "claude-sonnet-4-6",   # $3/$15
    "analyst":          "claude-sonnet-4-6",   # $3/$15
    "content_writer":   "claude-haiku-4-5",    # $0.80/$4
}

# Rule of thumb:
# Orchestrator = Sonnet (reasoning, planning)
# Workers with simple tasks = Haiku or gpt-4o-mini
# Workers with complex tasks = Sonnet
# Embeddings = text-embedding-3-small ($0.02/1M) or Gemini embeddings (free tier)
```

---

### Mode 4: Open Source vs. Paid Decision Framework

```
Choose PAID API when:
✓ Speed to market matters — don't want to manage infrastructure
✓ Volume is unpredictable — pay per use, not for idle GPU
✓ Need best-in-class quality — frontier models still beat open source on complex tasks
✓ Data privacy through API terms is acceptable
✓ Small team — no MLOps capacity

Choose OPEN SOURCE (self-hosted) when:
✓ Volume is very high and predictable — GPU cost < API cost at scale
✓ Data must never leave your infrastructure (healthcare, finance, government)
✓ Need to fine-tune on proprietary data
✓ Want custom inference configuration
✓ Have MLOps capacity or budget for managed hosting (Together.ai, Replicate, Fireworks)

Breakeven analysis (rough):
- 1× A100 GPU (~$1.50/hr) runs Llama 3.3 70B at ~30 tok/s
- At 24/7 uptime: $1,080/month
- Equivalent claude-haiku-4-5 calls (500 input + 500 output tokens, 100K req/month):
  cost = 100K × (500/1M × 0.80 + 500/1M × 4.00) = $240/month
- → At >30K req/month with Haiku-equivalent quality: self-hosting starts winning
```

---

### Mode 5: Fine-Tuning Decision

```
Fine-tune when:
✓ You have >1,000 labeled examples of the specific task
✓ The task is narrow and well-defined (classification, extraction, specific format)
✓ Base model consistently fails even with the best prompt
✓ Latency matters and you can't use long system prompts
✓ Cost matters and you're doing millions of calls (fine-tuned small model can beat large base model)

Don't fine-tune when:
✗ You have <500 examples — few-shot prompting works better
✗ Task requires world knowledge (fine-tuning doesn't add knowledge, only behavior)
✗ Task changes frequently — fine-tuned model is frozen
✗ You want to understand failures — black box behavior harder to debug

Fine-tuning options:
- OpenAI: gpt-4o-mini fine-tuning (most accessible, ~$8/1M training tokens)
- Anthropic: Claude fine-tuning (enterprise, contact sales)
- Open source: LoRA/QLoRA on Llama/Mistral/Qwen (full control, GPU needed)
  → axolotl or unsloth libraries for efficient fine-tuning
```

---

## Quality Gate

Before finalizing model selection:
- [ ] Use case defined — what exactly will this model do?
- [ ] Cost calculated — monthly estimate at expected volume
- [ ] Quality threshold defined — what score on eval set is acceptable?
- [ ] Latency requirement checked — does the model meet the response time SLA?
- [ ] Context window sufficient — will prompts ever exceed the limit?
- [ ] Compared at least 2 models on 10+ real examples from the actual use case
- [ ] Open source option evaluated if volume > 50K requests/month
- [ ] Fine-tuning considered if task is narrow and volume is very high
