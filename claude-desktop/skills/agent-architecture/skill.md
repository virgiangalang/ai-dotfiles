---
name: agent-architecture
description: AI agent design specialist covering agent components, memory systems, tool design, planning patterns (ReAct, Plan-and-Execute, Reflexion), and evaluation frameworks. Use when designing or building AI agents from scratch. Foundation skill for all agent development.
---

# Agent Architecture

## Skill Stack

- `multi-agent-systems` — when multiple agents need to coordinate
- `model-selection` — choose the right LLM brain for each agent
- `agent-deployment` — after design, go to deployment
- `n8n-automation` — when the agent orchestration layer is N8N

## Guardrails

- Never build an agent without defining: goal, tools, memory type, and success metric first
- Every tool the agent can call must have input validation — agents will call tools with bad inputs
- Never give an agent tools it doesn't need — minimal tool surface = fewer failure modes
- Always add an explicit stop condition — agents can loop forever without one
- Human-in-the-loop is not optional for irreversible actions (send email, post to social, charge card)
- Latency × cost × quality: picking two means sacrificing one — state the tradeoff explicitly

---

## Operating Modes

### Mode 1: Agent Anatomy — What Every Agent Needs

```
┌─────────────────────────────────────────────────────────┐
│                      AI AGENT                           │
│                                                         │
│  ┌──────────┐   ┌──────────┐   ┌──────────────────┐    │
│  │  Brain   │   │  Memory  │   │     Tools        │    │
│  │  (LLM)   │──▶│          │   │                  │    │
│  │          │   │ Short:   │   │ search_web()     │    │
│  │ Reasons  │   │ context  │   │ read_file()      │    │
│  │ Plans    │   │          │   │ call_api()       │    │
│  │ Decides  │   │ Long:    │   │ write_db()       │    │
│  │          │   │ vector   │   │ send_email()     │    │
│  └──────────┘   │ store    │   │                  │    │
│       │         └──────────┘   └──────────────────┘    │
│       │                                │                │
│       ▼                                ▼                │
│  ┌──────────┐                  ┌──────────────┐         │
│  │ Planner  │                  │  Executor    │         │
│  │ (chain   │                  │  (tool call  │         │
│  │  of      │                  │   + result   │         │
│  │  thought)│                  │   parsing)   │         │
│  └──────────┘                  └──────────────┘         │
└─────────────────────────────────────────────────────────┘
```

**The 4 design decisions before writing code:**
1. **Goal** — what specific outcome does success look like?
2. **Tools** — what APIs/functions does it need? (minimum set)
3. **Memory** — does it need to remember across calls?
4. **Human checkpoints** — when does a human need to approve before continuing?

---

### Mode 2: Planning Patterns

**ReAct (Reason + Act) — most common pattern:**
```python
# The model interleaves thought, action, observation
# Thought: what should I do?
# Action: call a tool
# Observation: what did the tool return?
# ... repeat until goal achieved

from langchain.agents import create_react_agent
from langchain import hub

prompt = hub.pull("hwchase17/react")
agent = create_react_agent(llm=llm, tools=tools, prompt=prompt)
agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True, max_iterations=10)

result = agent_executor.invoke({"input": "What is the revenue from top 3 customers this month?"})
```

**ReAct loop (what the LLM actually does):**
```
Thought: I need to find top 3 customers by revenue this month. I'll query the database.
Action: query_database
Action Input: {"sql": "SELECT customer_id, SUM(amount) FROM orders WHERE order_date >= '2025-06-01' GROUP BY 1 ORDER BY 2 DESC LIMIT 3"}
Observation: [{"customer_id": "C001", "sum": 45000000}, {"customer_id": "C002", "sum": 38000000}, {"customer_id": "C003", "sum": 29000000}]

Thought: Now I need customer names. I'll query again.
Action: query_database
Action Input: {"sql": "SELECT id, name FROM customers WHERE id IN ('C001', 'C002', 'C003')"}
Observation: [{"id": "C001", "name": "PT Maju Jaya"}, ...]

Thought: I have all the data I need. I can answer now.
Final Answer: Top 3 customers this month are: 1. PT Maju Jaya (Rp 45M), 2. ...
```

**Plan-and-Execute — for complex multi-step tasks:**
```python
# Step 1: Planner creates the full plan upfront
# Step 2: Executor executes each step, replanning if needed

from langchain_experimental.plan_and_execute import (
    PlanAndExecute, load_agent_executor, load_chat_planner
)

planner = load_chat_planner(llm)
executor = load_agent_executor(llm, tools)
agent = PlanAndExecute(planner=planner, executor=executor)

# Good for: research tasks, multi-source data gathering, report generation
```

**Reflexion — agent critiques its own output:**
```python
# After each action, the agent evaluates its own output quality
# Then decides: is this good enough, or do I need to redo?

reflexion_prompt = """
You are completing the task: {task}
Your previous attempt: {previous_output}
Evaluation: {evaluation}

Based on the evaluation, either:
1. Accept the output if it meets quality criteria
2. Refine and retry with a specific improvement in mind

What do you do?
"""
# Good for: content generation, code writing, analysis tasks where quality matters
```

---

### Mode 3: Memory Systems

**Short-term (conversation buffer) — simplest:**
```python
from langchain.memory import ConversationBufferMemory, ConversationSummaryMemory

# Buffer: keeps full history (expensive for long conversations)
memory = ConversationBufferMemory(return_messages=True, memory_key="chat_history")

# Summary: LLM summarizes old messages (cheap, loses detail)
memory = ConversationSummaryMemory(llm=llm, max_token_limit=500)

# Window: keeps last N messages (good balance)
from langchain.memory import ConversationBufferWindowMemory
memory = ConversationBufferWindowMemory(k=10, return_messages=True)
```

**Long-term (vector store) — for semantic memory:**
```python
from langchain.vectorstores import Chroma
from langchain.embeddings import OpenAIEmbeddings
from langchain.memory import VectorStoreRetrieverMemory

embedding = OpenAIEmbeddings()
vectorstore = Chroma(embedding_function=embedding, persist_directory="./memory_store")
retriever = vectorstore.as_retriever(search_kwargs={"k": 5})

# Memory that retrieves semantically similar past conversations
memory = VectorStoreRetrieverMemory(retriever=retriever)

# Usage: agent stores interaction → later retrieves relevant context
memory.save_context(
    {"input": "customer prefers email communication"},
    {"output": "noted, will use email for this customer"}
)
relevant = memory.load_memory_variables({"prompt": "how to contact this customer?"})
```

**Entity memory — tracks facts about entities:**
```python
from langchain.memory import ConversationEntityMemory

# Tracks: "Customer X has LTV of Rp 50M", "Project Y deadline is Aug 1"
memory = ConversationEntityMemory(llm=llm)
# Automatically extracts and updates entity facts from conversation
```

---

### Mode 4: Tool Design

**Tool anatomy (LangChain):**
```python
from langchain.tools import tool
from pydantic import BaseModel, Field

class QueryInput(BaseModel):
    sql: str = Field(description="The SQL query to execute. SELECT only — no INSERT/UPDATE/DELETE.")
    limit: int = Field(default=100, description="Maximum rows to return. Max 1000.")

@tool("query_database", args_schema=QueryInput)
def query_database(sql: str, limit: int = 100) -> str:
    """
    Execute a read-only SQL query against the analytics database.
    Returns results as JSON. Use for any data retrieval task.
    IMPORTANT: Only SELECT statements are allowed.
    """
    # Input validation — critical
    sql_clean = sql.strip().upper()
    if not sql_clean.startswith('SELECT'):
        return "Error: only SELECT queries are allowed"
    if limit > 1000:
        limit = 1000

    try:
        results = db.execute(sql + f" LIMIT {limit}")
        return json.dumps(results.fetchall(), default=str)
    except Exception as e:
        return f"Query failed: {str(e)}"

# Tool descriptions are part of the prompt — write them for an LLM, not a human
# Include: what it does, when to use it, what it returns, what NOT to do with it
```

**Tool set design principles:**
```python
# WRONG: generic, overlapping tools
tools = [
    Tool("web_search", ...),           # too vague
    Tool("google_search", ...),        # duplicate
    Tool("search_internet", ...),      # duplicate again
    Tool("database_anything", ...),    # too broad — agent will use for writes
]

# RIGHT: specific, non-overlapping, minimal
tools = [
    Tool("search_company_info", ...),      # specific search scope
    Tool("query_sales_data", ...),         # read-only, specific table access
    Tool("send_slack_notification", ...),  # write action, specific channel
    Tool("generate_pdf_report", ...),      # output action
]
# Human approves before: send_slack, generate_pdf (irreversible)
```

---

### Mode 5: Building with Claude (Anthropic SDK)

```python
import anthropic

client = anthropic.Anthropic()

# Tool definition for Claude
tools = [
    {
        "name": "query_analytics",
        "description": "Query the analytics database. Read-only. Returns JSON.",
        "input_schema": {
            "type": "object",
            "properties": {
                "sql": {
                    "type": "string",
                    "description": "SELECT SQL query"
                },
                "date_range": {
                    "type": "string",
                    "enum": ["today", "last_7_days", "last_30_days", "last_90_days"],
                    "description": "Date range to filter data"
                }
            },
            "required": ["sql"]
        }
    }
]

def run_agent(user_message: str, max_rounds: int = 10) -> str:
    messages = [{"role": "user", "content": user_message}]

    for _ in range(max_rounds):
        response = client.messages.create(
            model="claude-sonnet-4-6",
            max_tokens=4096,
            tools=tools,
            messages=messages
        )

        # Check stop reason
        if response.stop_reason == "end_turn":
            # Extract text response
            return next(b.text for b in response.content if b.type == "text")

        if response.stop_reason == "tool_use":
            # Execute tool calls
            tool_results = []
            for block in response.content:
                if block.type == "tool_use":
                    result = execute_tool(block.name, block.input)
                    tool_results.append({
                        "type": "tool_result",
                        "tool_use_id": block.id,
                        "content": str(result)
                    })

            # Add assistant response + tool results to messages
            messages.append({"role": "assistant", "content": response.content})
            messages.append({"role": "user", "content": tool_results})

    return "Max iterations reached"

def execute_tool(name: str, inputs: dict) -> str:
    if name == "query_analytics":
        return query_database(inputs["sql"])
    raise ValueError(f"Unknown tool: {name}")
```

---

### Mode 6: Agent Evaluation

```python
# Evaluate agents on: task success, accuracy, latency, cost, tool call efficiency

import time

class AgentEvaluator:
    def __init__(self, agent):
        self.agent = agent
        self.results = []

    def evaluate(self, test_cases: list[dict]) -> dict:
        for case in test_cases:
            start = time.time()
            
            # Track token usage
            with token_counter() as counter:
                output = self.agent.run(case["input"])
            
            result = {
                "input": case["input"],
                "expected": case["expected"],
                "actual": output,
                "latency_sec": time.time() - start,
                "tokens_used": counter.total,
                "cost_usd": counter.cost,
                "tool_calls": counter.tool_calls,
                # LLM-as-judge: ask another LLM to grade the output
                "quality_score": self.llm_judge(case["expected"], output),
            }
            self.results.append(result)
        
        return {
            "avg_quality": sum(r["quality_score"] for r in self.results) / len(self.results),
            "avg_latency": sum(r["latency_sec"] for r in self.results) / len(self.results),
            "avg_cost": sum(r["cost_usd"] for r in self.results) / len(self.results),
            "task_success_rate": sum(1 for r in self.results if r["quality_score"] >= 0.8) / len(self.results),
        }

    def llm_judge(self, expected: str, actual: str) -> float:
        # Use a separate LLM call to judge output quality (0.0 to 1.0)
        prompt = f"Expected: {expected}\nActual: {actual}\nRate similarity 0.0 to 1.0:"
        return float(llm.invoke(prompt).content)
```

---

## Quality Gate

Before shipping an agent to production:
- [ ] Goal defined — specific success criteria, not vague objectives
- [ ] Tool surface minimized — no tools the agent doesn't need
- [ ] Every tool has input validation — bad inputs return clear errors, not exceptions
- [ ] Stop condition defined — max iterations or explicit "task complete" signal
- [ ] Memory type chosen and justified — don't add vector memory if conversation buffer is enough
- [ ] Human-in-the-loop for all irreversible actions
- [ ] Evaluated on ≥10 test cases with LLM-as-judge scoring
- [ ] Latency and cost measured and within acceptable range
- [ ] Error handling: what happens when a tool fails? Agent should degrade gracefully.
