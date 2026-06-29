# Complete Skill, Agent & Command Guide

> **For:** Anyone who just cloned this repo and wants to know how to use it.  
> **Repo:** [github.com/virgiangalang/ai-dotfiles](https://github.com/virgiangalang/ai-dotfiles)

---

## Table of Contents

1. [How It Works](#1-how-it-works)
2. [Setup](#2-setup)
3. [Skills, Agents & Commands — The Basics](#3-skills-agents--commands--the-basics)
4. [Mapping by Use Case](#4-mapping-by-use-case)
   - [Web App (React / Vite / TypeScript)](#web-app-react--vite--typescript)
   - [Mobile App](#mobile-app)
   - [Backend & API](#backend--api)
   - [Database & Supabase](#database--supabase)
   - [Trading & Finance](#trading--finance)
   - [Security](#security)
   - [Code Review & Quality](#code-review--quality)
   - [Documents & Reports](#documents--reports)
   - [AI / Agent Development](#ai--agent-development)
5. [Complete Skill Reference](#5-complete-skill-reference)
6. [Complete Agent Reference](#6-complete-agent-reference)
7. [Complete Command Reference](#7-complete-command-reference)
8. [Tips & Tricks](#8-tips--tricks)

---

## 1. How It Works

This repo is a collection of AI "tools" that load into your coding agent (Claude Code, Cursor, etc.).

There are three types:

| Type | What It Is | How It Activates |
|------|-----------|-----------------|
| **Skills** | Domain knowledge files — how to do something | Automatically when relevant, or invoked explicitly |
| **Agents** | Specialized AI roles — a code reviewer, a market analyst, a security auditor | Claude spawns the right one, or you ask for it |
| **Commands** | Slash shortcuts — `/tdd`, `/plan`, `/code-review` | Type them directly |

**Important:** Not all 463 skills are active at the same time. They load on demand. Claude picks what's relevant to your request — or you can ask for a specific one explicitly.

**Always-on (no trigger needed):**
- `ecc-rules/common/` → coding standards, security rules, testing requirements
- `ecc-rules/typescript/` → TypeScript strict rules
- `ecc-rules/react/` → React best practices

---

## 2. Setup

### Windows
```powershell
git clone https://github.com/virgiangalang/ai-dotfiles.git
cd ai-dotfiles
.\setup.ps1
```

### Mac / Linux
```bash
git clone https://github.com/virgiangalang/ai-dotfiles.git
cd ai-dotfiles
bash setup.sh
```

Restart Claude Code after setup. Everything installs to `~/.claude/`.

> **Requirements:** Node.js v18+, Git

---

## 3. Skills, Agents & Commands — The Basics

### How Skills Load

```
You: "review this React component"
Claude: loads react-patterns skill + spawns react-reviewer agent automatically

You: "backtest RSI strategy"
Claude: loads trader-backtest skill + activates trading pipeline agents

You: "fix this build error"
Claude: spawns build-error-resolver agent
```

**Invoking a skill explicitly:**
```
"use the supabase-patterns skill to help me with RLS"
"load the TDD workflow for this feature"
"use trading pipeline to analyze BTCUSDT"
```

### How Agents Work

Agents are specialist AI roles. Claude spawns them automatically, or you can request one:
```
"review my TypeScript code"   → typescript-reviewer
"audit security of this API"  → security-reviewer
"analyze market conditions"   → market-analyst
```

### How Commands Work

Type slash commands directly in the chat:
```
/tdd              → Test-driven development workflow
/plan             → Implementation planning
/code-review      → Code quality review
/security-scan    → Security audit
/e2e              → Generate & run E2E tests
```

---

## 4. Mapping by Use Case

### Web App (React / Vite / TypeScript)

| Situation | What Activates |
|-----------|---------------|
| Start a new project | skill: `new-project` |
| Build a React component | skill: `react-patterns`, agent: `react-reviewer` |
| Performance optimization | skill: `react-performance` |
| Write tests | skill: `react-testing`, command: `/react-test` |
| Vite setup | skill: `vite-patterns` |
| Deploy to Vercel | skill: `vercel-serverless` |
| Supabase integration | skill: `supabase-patterns` |
| Build errors | agent: `react-build-resolver`, command: `/build-fix` |
| TDD | skill: `test-driven-development`, command: `/tdd` |
| Brainstorm a feature | skill: `brainstorming` |
| Code review | agent: `code-reviewer`, `typescript-reviewer` |
| Security audit | agent: `security-reviewer`, command: `/security-scan` |
| UI/UX design | skill: `frontend-design`, `frontend-patterns` |
| Accessibility | skill: `frontend-a11y`, agent: `a11y-architect` |

**Example full-feature workflow:**
```
1. "brainstorm feature X"           → brainstorming skill
2. "make an implementation plan"    → /plan
3. "write tests first"              → /tdd
4. "review what I just wrote"       → /code-review
5. "check for security issues"      → /security-scan
6. "create a PR"                    → /commit-push-pr
```

---

### Mobile App

| Platform | Skill | Agent | Command |
|----------|-------|-------|---------|
| React Native / Expo | `mobile-rn` | `react-reviewer` | `/react-review` |
| Flutter / Dart | `dart-flutter-patterns`, `flutter-dart-code-review` | `flutter-reviewer`, `dart-build-resolver` | `/flutter-review`, `/flutter-build` |
| Kotlin / Android | `kotlin-patterns`, `kotlin-coroutines-flows` | `kotlin-reviewer`, `kotlin-build-resolver` | `/kotlin-review` |
| Swift / iOS | `swift-actor-persistence`, `swift-concurrency-6-2` | `swift-reviewer`, `swift-build-resolver` | — |
| Compose Multiplatform | `compose-multiplatform-patterns` | `kotlin-reviewer` | — |
| HarmonyOS | — | `harmonyos-app-resolver` | — |

---

### Backend & API

| Tech | Skill | Agent | Command |
|------|-------|-------|---------|
| Node.js | `backend-patterns` | `typescript-reviewer` | — |
| Go | `golang-patterns`, `golang-testing` | `go-reviewer`, `go-build-resolver` | `/go-review`, `/go-build`, `/go-test` |
| Python | `python-patterns`, `python-testing` | `python-reviewer` | — |
| FastAPI | `fastapi-patterns` | `fastapi-reviewer` | `/fastapi-review` |
| Django | `django-patterns`, `django-security`, `django-tdd` | `django-reviewer`, `django-build-resolver` | — |
| Rust | `rust-patterns`, `rust-testing` | `rust-reviewer`, `rust-build-resolver` | `/rust-review`, `/rust-build` |
| C++ | — | `cpp-reviewer`, `cpp-build-resolver` | `/cpp-review`, `/cpp-build` |
| C# | — | `csharp-reviewer` | — |
| Java / Spring Boot | `springboot-patterns` | `java-reviewer`, `java-build-resolver` | — |
| Docker | `docker-patterns` | — | — |
| Kubernetes | `kubernetes-patterns` | — | — |
| API Design | `api-design`, `api-connector-builder` | `code-architect` | — |
| Hexagonal Architecture | `hexagonal-architecture` | `architect` | — |

---

### Database & Supabase

| Task | What to Use |
|------|------------|
| RLS policies, RPC, Auth | skill: `supabase-patterns` |
| Query optimization | agent: `database-reviewer` |
| Schema design | agent: `database-reviewer`, `migration-engineer` |
| Create a migration | skill: `database-migrations`, command: `/migrate-create` |
| Validate a migration | command: `/migrate-validate` |
| Postgres patterns | skill: `postgres-patterns` |
| Redis | skill: `redis-patterns` |
| Prisma | skill: `prisma-patterns` |

---

### Trading & Finance

> Powered by **neural-trader** (Rust/NAPI engine) via the ruflo plugin.

#### The Trading Pipeline (in order):

```
Data → Market Analyst → Trading Strategist → Risk Analyst → Execute
```

| Step | Skill | Agent | Command |
|------|-------|-------|---------|
| **1. Ingest market data** | `market-ingest` | `data-engineer` | — |
| **2. Detect market regime** | `market-pattern`, `trader-regime` | `market-analyst` | — |
| **3. Design trading strategy** | `trader-signal`, `trader-train` | `trading-strategist` | — |
| **4. Risk management** | `trader-risk` | `risk-analyst` | — |
| **5. Backtest** | `trader-backtest`, `trader-cloud-backtest` | `backtest-engineer` | — |
| **6. Portfolio analysis** | `trader-portfolio`, `trader-portfolio-cg` | — | — |
| **7. Explain the model** | `trader-explain` | — | — |
| **8. Neural training** | `neural-train` | — | — |

**Quick examples:**
```
"analyze the BTC market right now"          → market-analyst agent
"backtest RSI(14) crossover strategy"       → backtest-engineer + trader-backtest
"calculate risk for 10% of portfolio"       → risk-analyst + trader-risk
"train a new model on this data"            → neural-train skill
"explain why the model took this position"  → trader-explain skill
```

**Technical analysis supported:**
- RSI, MACD, Bollinger Bands
- Volume profile
- Market regime classification
- Z-score anomaly detection
- Walk-forward validation
- Monte Carlo simulation

> ⚠️ For backtesting and analysis only. Past performance ≠ future results.

---

### Security

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| General security audit | `security-review` | `security-reviewer`, `security-auditor` | `/security-scan` |
| Bug bounty hunting | `security-bounty-hunter` | — | — |
| DeFi / AMM security | `defi-amm-security` | — | — |
| HIPAA / PHI compliance | `hipaa-compliance`, `healthcare-phi-compliance` | `healthcare-reviewer` | — |
| PII detection | `pii-detect` | — | — |
| AI safety & threat | `safety-guard` | `safety-specialist` | — |
| Supply chain audit | — | `opensource-sanitizer` | — |

---

### Code Review & Quality

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| General code review | — | `code-reviewer` | `/code-review` |
| PR review | — | `pr-test-analyzer` | `/review-pr` |
| TypeScript | — | `typescript-reviewer` | — |
| React / JSX | — | `react-reviewer` | `/react-review` |
| Silent failures | — | `silent-failure-hunter` | — |
| Comment quality | — | `comment-analyzer` | — |
| Type design | — | `type-design-analyzer` | — |
| Refactor & cleanup | — | `refactor-cleaner` | — |
| E2E testing | — | `e2e-runner` | `/e2e` |
| TDD | skill: `test-driven-development` | `tdd-guide` | `/tdd` |

---

### Documents & Reports

| Task | Skill | How to Use |
|------|-------|------------|
| Create a Word file (.docx) | `docx` | "create a Word report about X" |
| Create a PDF | `pdf` | "export this to PDF" |
| Create a PowerPoint | `pptx` | "build a presentation about Y" |
| Create an Excel file | `xlsx` | "make a spreadsheet with this data" |
| AI product planning | `ai-product-builder` | "help me design an AI product" |
| Multi-LLM perspective | `llm-council` | "get multiple AI opinions on this" |

---

### AI / Agent Development

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| Build a Claude Code plugin | skill: `create-plugin` | `plugin-developer` | `/create-plugin` |
| Create a new skill | skill: `skill-development` | — | `/skill-create` |
| Create a new agent | skill: `agent-development` | — | — |
| MCP integration | skill: `mcp-integration` | — | — |
| Multi-agent orchestration | skill: `agentic-engineering` | `sparc-orchestrator` | `/multi-workflow` |
| Autonomous loops | skill: `autonomous-loops` | `autopilot-coordinator` | `/loop` |
| Deep research | — | `deep-researcher` | — |
| Knowledge graph | — | `graph-navigator` | — |
| Vector / embeddings | — | `vector-engineer` | — |
| RAG memory | skill: `memory-search` | `memory-specialist` | — |
| SPARC methodology | skill: `sparc-spec` | `sparc-orchestrator` | — |

---

## 5. Complete Skill Reference

### 🎨 Custom Skills (Galang's Curated — 14 skills)

| Skill | Description |
|-------|-------------|
| `supabase-patterns` | RLS policies, RPC functions, auth patterns, migrations |
| `vercel-serverless` | Critical `api/` folder rules, handler patterns, cron jobs |
| `payment-gateway-id` | Indonesian payment gateways — Midtrans, Xendit, Doku |
| `mobile-rn` | React Native + Expo — setup, navigation, EAS build |
| `new-project` | Kickstart any new project from scratch |
| `ai-product-builder` | Build AI-powered products step by step |
| `llm-council` | Multi-LLM perspective for important decisions |
| `consolidate-memory` | Consolidate memory across sessions |
| `skill-creator` | Create new skills for your workflow |
| `schedule` | Create schedules and timelines |
| `docx` | Generate / edit Word documents |
| `pdf` | Generate PDFs |
| `pptx` | Create PowerPoint presentations |
| `xlsx` | Create Excel spreadsheets |

### ⚡ ECC Skills (271 skills — core development)

| Category | Skills |
|----------|--------|
| **React** | `react-patterns`, `react-performance`, `react-testing` |
| **Next.js** | `nextjs-turbopack` |
| **API** | `api-design`, `api-connector-builder` |
| **Security** | `security-review`, `security-bounty-hunter`, `defi-amm-security` |
| **Database** | `database-migrations`, `postgres-patterns` |
| **TDD** | `tdd-workflow`, `django-tdd`, `springboot-tdd` |
| **Flutter** | `dart-flutter-patterns`, `flutter-dart-code-review`, `compose-multiplatform-patterns` |
| **Swift** | `swift-actor-persistence`, `swift-concurrency-6-2`, `swiftui-patterns` |
| **Kotlin** | `kotlin-patterns`, `kotlin-coroutines-flows`, `kotlin-ktor-patterns` |
| **Go** | `golang-patterns`, `golang-testing` |
| **Python** | `python-patterns`, `python-testing`, `fastapi-patterns`, `django-patterns` |
| **Rust** | `rust-patterns`, `rust-testing` |
| **Java** | `springboot-patterns`, `springboot-security` |
| **DevOps** | `docker-patterns`, `kubernetes-patterns` |
| **Architecture** | `hexagonal-architecture`, `backend-patterns`, `architecture-decision-records` |
| **Frontend** | `frontend-patterns`, `frontend-design-direction`, `frontend-a11y` |
| **AI/ML** | `agentic-engineering`, `autonomous-loops`, `continuous-learning` |
| **Git** | `git-workflow` |

### 🔁 Ruflo Skills (129 skills — trading & automation)

| Category | Skills |
|----------|--------|
| **Trading** | `trader-backtest`, `trader-cloud-backtest`, `trader-explain`, `trader-portfolio`, `trader-regime`, `trader-risk`, `trader-signal`, `trader-train` |
| **Market Data** | `market-ingest`, `market-pattern` |
| **Neural** | `neural-train` |
| **Memory / RAG** | `memory-search`, `memory-bridge`, `agentdb-query` |
| **Browser Automation** | `browser-auth-flow`, `browser-extract`, `browser-form-fill`, `browser-test`, `browser-record`, `browser-replay` |
| **Cost Tracking** | `cost-track`, `cost-optimize`, `cost-summary`, `cost-burn` |
| **Vector** | `vector-embed`, `vector-search`, `vector-cluster`, `vector-hyperbolic` |
| **Autonomous** | `autopilot-loop`, `autopilot-predict`, `continuous-agent-loop` |
| **SPARC** | `sparc-spec`, `sparc-implement`, `sparc-refine` |
| **Safety** | `safety-scan`, `pii-detect` |
| **Swarm** | `swarm-init`, `nested-subagents` |

### 💪 Superpowers Skills (14 skills — workflow essentials)

| Skill | When to Use |
|-------|-------------|
| `brainstorming` | Before starting any feature — mandatory |
| `test-driven-development` | Write tests before code |
| `systematic-debugging` | Debugging complex errors |
| `writing-plans` | Create an implementation plan |
| `executing-plans` | Execute a plan step by step |
| `dispatching-parallel-agents` | Run multiple agents simultaneously |
| `using-git-worktrees` | Parallel development without conflicts |
| `subagent-driven-development` | Delegate to subagents |
| `verification-before-completion` | Check results before finishing |
| `requesting-code-review` | Ask for code review |
| `receiving-code-review` | Process review feedback |
| `finishing-a-development-branch` | Wrap up a branch before merging |
| `writing-skills` | Create a new skill |
| `using-superpowers` | Guide to using superpowers |

### 🧠 Claude-Mem Skills (17 skills — memory & navigation)

| Skill | Description |
|-------|-------------|
| `learn-codebase` | Learn a new codebase from scratch |
| `pathfinder` | Navigate large codebases |
| `smart-explore` | Intelligent codebase exploration |
| `make-plan` | Plan from memory |
| `mem-search` | Search memory |
| `knowledge-agent` | Knowledge base agent |
| `standup` | Generate standup report |
| `timeline-report` | Progress timeline report |
| `version-bump` | Bump version numbers |
| `babysit` | Monitor a PR until merged |
| `weekly-digests` | Weekly progress summaries |

---

## 6. Complete Agent Reference

### 🏗️ Planning & Architecture

| Agent | When to Use |
|-------|-------------|
| `planner` | Complex feature requests, large refactors |
| `architect` | System architecture decisions |
| `code-architect` | Design a feature within an existing codebase |
| `code-explorer` | Understand an existing feature before modifying it |
| `sparc-orchestrator` | Large projects using SPARC methodology |
| `domain-modeler` | DDD — bounded contexts, aggregate roots |

### 🔍 Code Review

| Agent | Specialization |
|-------|---------------|
| `code-reviewer` | General — quality, security, maintainability |
| `typescript-reviewer` | TypeScript / JavaScript |
| `react-reviewer` | React / JSX / TSX |
| `python-reviewer` | Python, PEP 8 |
| `go-reviewer` | Go, idioms, concurrency |
| `rust-reviewer` | Rust, ownership, lifetimes |
| `kotlin-reviewer` | Kotlin, Android, Compose |
| `flutter-reviewer` | Flutter, Dart |
| `swift-reviewer` | Swift, iOS / macOS |
| `java-reviewer` | Java, Spring Boot |
| `fastapi-reviewer` | FastAPI, async, Pydantic |
| `django-reviewer` | Django, ORM, DRF |
| `cpp-reviewer` | C++, memory safety |
| `vue-reviewer` | Vue.js, Composition API |
| `database-reviewer` | SQL, Supabase, Postgres, RLS |
| `security-reviewer` | Security, OWASP Top 10 |

### 🔨 Build Error Resolvers

| Agent | For |
|-------|-----|
| `build-error-resolver` | TypeScript and general build errors |
| `react-build-resolver` | Vite, webpack, Next.js |
| `dart-build-resolver` | Flutter, pub, build_runner |
| `kotlin-build-resolver` | Gradle, Kotlin |
| `swift-build-resolver` | Xcode, SPM |
| `go-build-resolver` | go vet, build |
| `rust-build-resolver` | cargo, borrow checker |
| `cpp-build-resolver` | CMake, linker |
| `java-build-resolver` | Maven, Gradle |
| `django-build-resolver` | pip, migrations |

### 📈 Trading & Finance

| Agent | Role in Pipeline |
|-------|-----------------|
| `market-analyst` | Regime detection, technical analysis (RSI, MACD, etc.) |
| `trading-strategist` | Strategy design, LSTM / Transformer models |
| `risk-analyst` | VaR/CVaR, Kelly Criterion, position sizing |
| `backtest-engineer` | Walk-forward validation, Monte Carlo |
| `data-engineer` | Ingest & normalize OHLCV data |
| `cost-analyst` | Token usage & cost per agent |

### 🧠 Memory & Research

| Agent | Function |
|-------|---------|
| `memory-specialist` | RAG memory, hybrid search, consolidation |
| `deep-researcher` | Multi-source research and synthesis |
| `intelligence-specialist` | Self-learning, pattern extraction |
| `graph-navigator` | Knowledge graph, entity relations |
| `vector-engineer` | Embeddings, HNSW indexing |

### 🔒 Security & Safety

| Agent | Function |
|-------|---------|
| `security-reviewer` | OWASP, vulnerability detection |
| `security-auditor` | Full security audit |
| `safety-specialist` | AI safety, threat detection |
| `opensource-sanitizer` | Scan repo before open-sourcing |

### 🤖 AI / Automation

| Agent | Function |
|-------|---------|
| `sparc-orchestrator` | SPARC 5-phase methodology |
| `autopilot-coordinator` | Autonomous task completion |
| `coordinator` | Swarm multi-agent coordination |
| `goal-planner` | GOAP — action planning with A* |
| `workflow-specialist` | Workflow automation |

### 📱 Other Specialists

| Agent | Function |
|-------|---------|
| `tdd-guide` | Test-Driven Development |
| `e2e-runner` | E2E testing (Playwright) |
| `refactor-cleaner` | Dead code cleanup |
| `performance-optimizer` | Performance bottleneck analysis |
| `a11y-architect` | Accessibility (WCAG 2.2) |
| `doc-updater` | Update documentation |
| `harmonyos-app-resolver` | HarmonyOS / ArkTS |
| `seo-specialist` | SEO audit & optimization |
| `plugin-developer` | Claude Code plugin development |
| `marketing-agent` | Marketing copy and campaigns |

---

## 7. Complete Command Reference

### ECC Commands

| Command | Function |
|---------|---------|
| `/tdd` | Test-Driven Development workflow |
| `/plan` | Implementation planning |
| `/e2e` | Generate & run E2E tests |
| `/code-review` | Quality review |
| `/build-fix` | Fix build errors |
| `/learn` | Extract patterns from this session |
| `/skill-create` | Generate a new skill |
| `/go-review` | Review Go code |
| `/go-build` | Build Go project |
| `/go-test` | Test Go project |
| `/react-review` | Review React code |
| `/react-build` | Build React project |
| `/react-test` | Test React project |
| `/flutter-review` | Review Flutter code |
| `/flutter-build` | Build Flutter |
| `/rust-review` | Review Rust code |
| `/rust-build` | Build Rust |
| `/python-review` | Review Python code |
| `/security-scan` | Security audit |
| `/feature-dev` | Full feature development workflow |
| `/refactor-clean` | Clean up dead code |
| `/update-docs` | Update documentation |
| `/pr` | Create a PR |
| `/epic-decompose` | Break down an epic into tasks |

### Ruflo Commands

| Command | Function |
|---------|---------|
| `/autopilot` | Enable autonomous mode |
| `/swarm` | Initialize agent swarm |
| `/goals` | Track long-term goals |
| `/recall` | Quick memory recall |
| `/memory` | Memory management |
| `/workflow` | Workflow management |
| `/vector` | Vector / embeddings operations |
| `/testgen` | Auto-generate tests |
| `/sparc` | SPARC methodology |
| `/migrate` | Database migration |

### Anthropic Official Commands

| Command | Function |
|---------|---------|
| `/commit` | Create a git commit |
| `/commit-push-pr` | Commit + push + create PR |
| `/code-review` | Review a PR |
| `/feature-dev` | Feature development workflow |
| `/create-plugin` | Create a new Claude Code plugin |
| `/new-sdk-app` | Create a Claude Agent SDK app |

---

## 8. Tips & Tricks

### Invoke a Specific Skill

If Claude doesn't automatically load the skill you want, just ask directly:

```
"use the react-patterns skill to review this component"
"load the trading pipeline for BTCUSDT analysis"
"use the supabase-patterns skill before writing this query"
```

### Parallel Agents for Large Tasks

```
"review this code from 3 angles: security, performance, and TypeScript quality"
→ Claude spawns 3 agents simultaneously: security-reviewer, performance-optimizer, typescript-reviewer
```

### Trading Quick Start

```
Step 1: "ingest 1 year of BTCUSDT data"       → data-engineer agent
Step 2: "analyze current market regime"        → market-analyst agent
Step 3: "backtest RSI(14) crossover strategy"  → backtest-engineer agent
Step 4: "calculate risk for 10% of portfolio"  → risk-analyst agent
```

### Start a New Project (any stack)

```
"I want to start a new [web/mobile/API] project with [React/Flutter/Go/etc], use the new-project skill"
```

### Keep This Repo Updated

```bash
cd ~/ai-dotfiles   # or wherever you cloned it
git pull
.\setup.ps1        # re-run to apply any new changes
```

### Create Your Own Skill

```
"create a new skill for [topic X]"
→ Claude uses skill-creator to generate the skill file
→ Save it in claude-desktop/skills/your-skill-name/skill.md
→ git add . && git commit -m "feat: add skill" && git push
```

---

*Curated by Galang — Automation Engineer · Southeast Asia*  
*Full repo: [github.com/virgiangalang/ai-dotfiles](https://github.com/virgiangalang/ai-dotfiles)*
