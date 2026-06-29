---
name: multi-agent-systems
description: Multi-agent orchestration specialist covering framework comparison (LangGraph, CrewAI, AutoGen, Claude Multi-Agent, OpenAI Swarm), communication patterns, role design, and state management. Use when building systems where multiple AI agents must collaborate, hand off work, or work in parallel.
---

# Multi-Agent Systems

## Skill Stack

- `agent-architecture` — design each individual agent before orchestrating them
- `model-selection` — different agents in the same system can use different models
- `agent-deployment` — deploy the orchestrated system to production
- `business-automation` — map business processes to agent teams

## Guardrails

- Never build multi-agent before you need it — a single good agent beats a broken swarm
- Every agent must have exactly one job — agents with multiple responsibilities fail at all of them
- Always define the communication contract between agents before writing code
- Shared state must be immutable from the agent's perspective — agents read state, orchestrator writes
- Every inter-agent handoff must include error handling — what if the downstream agent fails?
- Test with 2 agents before scaling to 10 — multi-agent complexity grows exponentially

---

## Framework Comparison

| Framework | Best For | Strength | Weakness |
|---|---|---|---|
| **LangGraph** | Complex state machines, conditional flows | Full control, visual debugging, Python | Steep learning curve |
| **CrewAI** | Team simulations, role-based tasks | Easy to define roles, fast setup | Less control over flow |
| **AutoGen** | Research, code generation, back-and-forth | Great for agent-to-agent conversation | Less structured |
| **Claude Multi-Agent** | Production, tool use, structured output | Best tool use, reliable | Claude API only |
| **OpenAI Swarm** | Simple hand-offs, teaching | Minimal, easy to understand | Experimental |
| **N8N / Make** | Business automation, no-code | No code needed, 400+ integrations | Limited reasoning |

---

## Operating Modes

### Mode 1: LangGraph — State Machine Orchestration

LangGraph models multi-agent systems as directed graphs where nodes are agents/functions and edges are conditional transitions.

```python
from langgraph.graph import StateGraph, END
from langchain_core.messages import HumanMessage, AIMessage
from typing import TypedDict, List

# 1. Define shared state — what all agents can read/write
class ResearchState(TypedDict):
    task: str
    research_data: List[str]
    analysis: str
    report: str
    quality_score: float
    revision_count: int

# 2. Define agent nodes
def researcher(state: ResearchState) -> ResearchState:
    """Agent 1: gather information"""
    data = search_tool.run(state["task"])
    return {**state, "research_data": data}

def analyst(state: ResearchState) -> ResearchState:
    """Agent 2: analyze the gathered data"""
    analysis = analyst_llm.invoke(
        f"Analyze this data about {state['task']}: {state['research_data']}"
    )
    return {**state, "analysis": analysis.content}

def writer(state: ResearchState) -> ResearchState:
    """Agent 3: write the final report"""
    report = writer_llm.invoke(
        f"Write a report based on: {state['analysis']}"
    )
    return {**state, "report": report.content}

def quality_checker(state: ResearchState) -> ResearchState:
    """Agent 4: score the report quality"""
    score = quality_llm.invoke(
        f"Score this report 0.0 to 1.0: {state['report']}"
    )
    return {**state, "quality_score": float(score.content)}

# 3. Conditional routing
def should_revise(state: ResearchState) -> str:
    if state["quality_score"] < 0.8 and state["revision_count"] < 3:
        return "revise"
    return "done"

# 4. Build the graph
workflow = StateGraph(ResearchState)
workflow.add_node("researcher", researcher)
workflow.add_node("analyst", analyst)
workflow.add_node("writer", writer)
workflow.add_node("quality_checker", quality_checker)

# 5. Define edges (flow)
workflow.set_entry_point("researcher")
workflow.add_edge("researcher", "analyst")
workflow.add_edge("analyst", "writer")
workflow.add_edge("writer", "quality_checker")

# Conditional: revise or done
workflow.add_conditional_edges(
    "quality_checker",
    should_revise,
    {"revise": "writer", "done": END}  # loop back to writer if quality low
)

# 6. Compile and run
app = workflow.compile()
result = app.invoke({
    "task": "Analyze the Indonesian fintech market",
    "research_data": [],
    "analysis": "",
    "report": "",
    "quality_score": 0.0,
    "revision_count": 0
})
```

**Parallel execution in LangGraph:**
```python
# Run multiple agents simultaneously, then merge
workflow.add_node("parallel_start", lambda s: s)  # fan-out
workflow.add_node("agent_a", agent_a)
workflow.add_node("agent_b", agent_b)
workflow.add_node("agent_c", agent_c)
workflow.add_node("merge", merge_results)  # fan-in

# All three run in parallel
from langgraph.graph import START
workflow.add_edge("parallel_start", "agent_a")
workflow.add_edge("parallel_start", "agent_b")
workflow.add_edge("parallel_start", "agent_c")
workflow.add_edge(["agent_a", "agent_b", "agent_c"], "merge")  # waits for all
```

---

### Mode 2: CrewAI — Role-Based Teams

CrewAI models multi-agent as a team of employees with roles, goals, and backstories.

```python
from crewai import Agent, Task, Crew, Process
from crewai_tools import SerperDevTool, WebsiteSearchTool

search_tool = SerperDevTool()
web_tool = WebsiteSearchTool()

# 1. Define agents with roles
market_researcher = Agent(
    role="Senior Market Research Analyst",
    goal="Find accurate, current market data and competitive intelligence",
    backstory="""You are a veteran market researcher with 15 years of experience 
    analyzing Southeast Asian markets. You never cite data without sources.""",
    tools=[search_tool, web_tool],
    llm=claude_llm,
    verbose=True,
    max_iter=5,
    allow_delegation=False  # this agent doesn't delegate
)

strategist = Agent(
    role="Business Strategy Director",
    goal="Convert market research into actionable strategic recommendations",
    backstory="""You are a McKinsey-trained strategist who thinks in frameworks.
    You always structure recommendations with clear rationale and trade-offs.""",
    llm=claude_llm,
    verbose=True,
    allow_delegation=True  # can ask other agents for help
)

# 2. Define tasks
research_task = Task(
    description="""Research the Indonesian B2B SaaS market.
    Find: market size (TAM/SAM/SOM), top 5 competitors, growth rate, and key trends.
    Required: cite sources for every data point.""",
    expected_output="A structured market research report with sourced data points",
    agent=market_researcher,
    output_file="research.md"
)

strategy_task = Task(
    description="""Based on the market research, develop a go-to-market strategy.
    Include: target segment, positioning, top 3 channels, 90-day action plan.
    Apply Porter's Five Forces to assess competitive position.""",
    expected_output="A GTM strategy document with concrete 90-day action plan",
    agent=strategist,
    context=[research_task]  # receives research_task output as input
)

# 3. Build crew
crew = Crew(
    agents=[market_researcher, strategist],
    tasks=[research_task, strategy_task],
    process=Process.sequential,  # or Process.hierarchical (manager → workers)
    verbose=True,
    memory=True,  # agents share memory across tasks
    max_rpm=10    # rate limit API calls
)

result = crew.kickoff(inputs={"market": "Indonesian B2B SaaS"})
```

---

### Mode 3: Claude Multi-Agent (Anthropic SDK)

The most production-ready approach — one orchestrator spawns workers using Claude's tool use.

```python
import anthropic

client = anthropic.Anthropic()

# Worker agents are just Claude API calls
def research_agent(topic: str) -> str:
    response = client.messages.create(
        model="claude-haiku-4-5-20251001",  # cheap model for workers
        max_tokens=2000,
        system="You are a research agent. Search and summarize information accurately.",
        messages=[{"role": "user", "content": f"Research: {topic}"}]
    )
    return response.content[0].text

def analyst_agent(data: str, question: str) -> str:
    response = client.messages.create(
        model="claude-sonnet-4-6",  # stronger model for analysis
        max_tokens=3000,
        system="You are a senior analyst. Provide structured analysis with clear insights.",
        messages=[{"role": "user", "content": f"Data: {data}\n\nAnalyze: {question}"}]
    )
    return response.content[0].text

# Orchestrator tools that invoke sub-agents
orchestrator_tools = [
    {
        "name": "spawn_researcher",
        "description": "Spawn a research sub-agent to gather information on a topic",
        "input_schema": {
            "type": "object",
            "properties": {
                "topic": {"type": "string", "description": "What to research"}
            },
            "required": ["topic"]
        }
    },
    {
        "name": "spawn_analyst",
        "description": "Spawn an analyst sub-agent to analyze data",
        "input_schema": {
            "type": "object",
            "properties": {
                "data": {"type": "string"},
                "question": {"type": "string"}
            },
            "required": ["data", "question"]
        }
    }
]

def orchestrator(user_request: str) -> str:
    messages = [{"role": "user", "content": user_request}]
    
    while True:
        response = client.messages.create(
            model="claude-sonnet-4-6",  # orchestrator uses best model
            max_tokens=4096,
            system="""You are an orchestrator that breaks down complex tasks and delegates to specialists.
            Use spawn_researcher for information gathering, spawn_analyst for analysis.
            Synthesize results from sub-agents into a final answer.""",
            tools=orchestrator_tools,
            messages=messages
        )
        
        if response.stop_reason == "end_turn":
            return response.content[0].text
        
        if response.stop_reason == "tool_use":
            tool_results = []
            for block in response.content:
                if block.type == "tool_use":
                    if block.name == "spawn_researcher":
                        result = research_agent(block.input["topic"])
                    elif block.name == "spawn_analyst":
                        result = analyst_agent(block.input["data"], block.input["question"])
                    
                    tool_results.append({
                        "type": "tool_result",
                        "tool_use_id": block.id,
                        "content": result
                    })
            
            messages.append({"role": "assistant", "content": response.content})
            messages.append({"role": "user", "content": tool_results})
```

---

### Mode 4: Communication Patterns

```
Sequential (pipeline):
A → B → C → D
Each agent receives the previous agent's output.
Use for: linear workflows, report generation, data transformation pipelines.

Parallel (fan-out / fan-in):
     ┌→ A ─┐
Start│→ B ─│→ Merge
     └→ C ─┘
Use for: independent research tasks, parallel data gathering, running analyses simultaneously.

Hierarchical (manager / worker):
     Manager (orchestrator)
    /    │    \
   A     B     C    (workers with specific skills)
Use for: complex tasks requiring different specialists, dynamic task assignment.

Debate (adversarial):
Agent A proposes → Agent B critiques → Agent A revises
Use for: high-stakes decisions, research validation, code review.

Round-robin:
A → B → C → A → B → ... until consensus
Use for: collaborative writing, iterative refinement.
```

---

### Mode 5: Agent Team Templates

**"Company of 10" — full business automation team:**
```python
AGENT_TEAM = {
    # C-Suite
    "ceo": {"model": "claude-sonnet-4-6", "role": "Orchestrator — breaks down goals, delegates, synthesizes"},
    
    # Operations
    "researcher":   {"model": "claude-haiku-4-5-20251001", "role": "Web search, data gathering, fact-checking"},
    "analyst":      {"model": "claude-sonnet-4-6", "role": "Data analysis, insight generation, reporting"},
    "writer":       {"model": "claude-haiku-4-5-20251001", "role": "Content creation, emails, reports"},
    
    # Technical
    "coder":        {"model": "claude-sonnet-4-6", "role": "Write, debug, and test code"},
    "reviewer":     {"model": "claude-sonnet-4-6", "role": "Code review, security check, quality gate"},
    
    # Business
    "marketer":     {"model": "claude-haiku-4-5-20251001", "role": "Campaign copy, social posts, ads"},
    "sales":        {"model": "claude-haiku-4-5-20251001", "role": "Prospect research, email outreach"},
    "support":      {"model": "claude-haiku-4-5-20251001", "role": "Customer inquiries, FAQ responses"},
    "finance":      {"model": "claude-haiku-4-5-20251001", "role": "Invoice generation, expense categorization"},
}

# CEO receives high-level goal → delegates to right specialists → synthesizes output
# Haiku handles volume tasks (emails, research, writing) — cheap at scale
# Sonnet handles complex reasoning (analysis, code, orchestration)
```

---

## Quality Gate

Before deploying a multi-agent system:
- [ ] Each agent has exactly one responsibility
- [ ] Communication contract defined — input format, output format, error format
- [ ] Orchestrator handles agent failure gracefully (retry, fallback, skip)
- [ ] Infinite loop prevention — max iterations or circuit breaker
- [ ] State is immutable from agent perspective — only orchestrator writes shared state
- [ ] Tested with 2 agents in isolation before full system test
- [ ] Cost modeled — multi-agent costs multiply quickly; calculate worst-case token spend
- [ ] Human-in-the-loop checkpoints for irreversible actions (send email, post to social, call API)
