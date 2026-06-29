# Complete Skill, Agent & Command Guide

> **Repo:** [github.com/virgiangalang/ai-dotfiles](https://github.com/virgiangalang/ai-dotfiles) &nbsp;·&nbsp; **Setup:** [README.md](README.md)

---

## 🎯 Start Here — Jump to Your Role

Find your role and go straight to what's relevant to you.

| Your Role | Jump To |
|-----------|---------|
| 💻 **Developer** (web / mobile / backend) | [Web App](#web-app-react--vite--typescript) · [Mobile](#mobile-app) · [Backend & API](#backend--api) · [Security](#security) · [Code Review](#code-review--quality) |
| 🚀 **Founder / CEO** | [Business & Strategy](#business--strategy) → `/biz-plan` `/pitch-deck` `/decision-matrix` |
| 📣 **CMO / Marketer** | [Marketing](#marketing) → `/marketing-plan` `/ads-brief` `/gtm-plan` `/growth-audit` |
| 📋 **Product Manager** | [Business & Strategy](#business--strategy) → `/product-roadmap` `/okr-workshop` `/jtbd` |
| 🔧 **Forward Deployed Engineer** | [Business & Strategy](#business--strategy) + [Web App](#web-app-react--vite--typescript) → full stack |
| 📊 **Data Analyst & BI Developer** | [Data Analytics & BI](#data-analytics--business-intelligence) → `/eda` `/sql-optimize` `/viz-brief` `/dashboard-audit` |
| ⚙️ **Automation Engineer** | [Automation Engineer](#automation-engineer--ai-agents) → `/agent-blueprint` `/biz-automate` `/agent-deploy` |
| 📈 **Quant / Trader** | [Trading & Finance](#trading--finance) → neural trader pipeline |

---

## Table of Contents

1. [How It Works](#1-how-it-works)
2. [Setup](#2-setup)
3. [Skills, Agents & Commands — The Basics](#3-skills-agents--commands--the-basics)
4. [Mapping by Use Case](#4-mapping-by-use-case)
   - [Business & Strategy](#business--strategy)
   - [Marketing](#marketing)
   - [Web App (React / Vite / TypeScript)](#web-app-react--vite--typescript)
   - [Mobile App](#mobile-app)
   - [Backend & API](#backend--api)
   - [Database & Supabase](#database--supabase)
   - [Trading & Finance](#trading--finance)
   - [Data Analytics & Business Intelligence](#data-analytics--business-intelligence)
   - [Automation Engineer — AI Agents](#automation-engineer--ai-agents)
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

**Important:** Not all 483 skills are active at the same time. They load on demand. Claude picks what's relevant to your request — or you can ask for a specific one explicitly.

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

### Business & Strategy

For founders, CEOs, executives, PMs, and consultants — business planning, analysis, and decision-making.

> **ECC skills already installed** (deep, evidence-first quality):  
> `market-research` · `competitive-platform-analysis` · `competitive-report-structure` · `product-lens` · `deep-research` · `marketing-campaign` · `finance-billing-ops`

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| **Market research & sizing** | `market-research` (ECC) | `market-researcher` | `/market-analysis` |
| **Competitor analysis** | `competitive-platform-analysis` (ECC) | `market-researcher` | — |
| **Business strategy (Porter's, Blue Ocean, Ansoff)** | `business-strategy` | `ceo-advisor` | `/biz-plan` |
| **Business Model Canvas** | `business-model-canvas` | `ceo-advisor` | `/bmc` |
| **OKR planning & review** | `okr-planning` | `okr-coach` | `/okr-workshop` |
| **Product roadmap & PRD** | `product-strategy` | `product-manager` | `/product-roadmap` |
| **Decision-making (RICE, pre-mortem, matrix)** | `decision-framework` | `ceo-advisor` | `/decision-matrix` |
| **Investor pitch deck** | `pitch-deck` | `pitch-coach` | `/pitch-deck` |
| **CSV / data analytics** | `data-analytics` | `business-analyst` | — |
| **Requirements & process mapping** | `solution-design` | `business-analyst` | — |
| **Executive briefs & board updates** | `stakeholder-comms` | `ceo-advisor` | `/exec-brief` |
| **Technical solution proposal** | `solution-design` | `solution-engineer` | `/solution-proposal` |
| **JTBD analysis** | — | `product-manager` | `/jtbd` |
| **Edtech curriculum & LMS** | `edutech-strategy` | `edutech-specialist` | — |

**Business workflow examples:**

```
"size the market for my product idea"
→ market-researcher agent + market-research (ECC) skill

"analyze our top 3 competitors"
→ competitive-platform-analysis (ECC) → competitive-report-structure (ECC)

"help me build our Q3 OKRs"
→ okr-coach agent + okr-planning skill + /okr-workshop

"review my investor pitch"
→ pitch-coach agent + pitch-deck skill

"analyze this CSV and give me the key metrics"
→ data-analytics skill + business-analyst agent

"build a strategic plan for entering a new market"
→ ceo-advisor agent + business-strategy + market-research (ECC)
```

---

### Marketing

For CMOs, growth marketers, brand leads, content teams, and ads managers — full-stack marketing intelligence.

> **ECC skills already installed:**  
> `market-research` · `competitive-platform-analysis` · `marketing-campaign` · `deep-research`

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| **Full marketing strategy + ICP + channels** | `marketing-strategy` | `cmo-advisor` | `/marketing-plan` |
| **Brand positioning, pillars, messaging** | `brand-strategy` | `brand-strategist` | `/brand-audit` |
| **Google Ads / Meta Ads / TikTok Ads** | `ads-performance` | `ads-manager` | `/ads-brief` |
| **CPL / MQL / SQL / CAC / LTV / ROAS** | `growth-metrics` | `marketing-analyst` | `/growth-audit` |
| **Content calendar + SEO content planning** | `content-strategy` | `content-strategist` | `/content-calendar` |
| **Ad copy / landing page / email copy** | `copywriting` | `copywriter` | `/copy-review` |
| **SEO audit + keyword research** | `seo-strategy` | `content-strategist` | `/seo-audit` |
| **Email sequence (welcome / nurture / re-engage)** | `email-marketing` | `copywriter` | `/email-sequence` |
| **Go-to-market plan** | `marketing-strategy` + `brand-strategy` | `cmo-advisor` | `/gtm-plan` |
| **Integrated campaign brief** | `marketing-strategy` + `copywriting` | `cmo-advisor` | `/campaign-brief` |
| **Organic social strategy** | `content-strategy` + `brand-strategy` | `social-media-strategist` | — |
| **Marketing funnel audit** | `growth-metrics` | `growth-marketer` | `/growth-audit` |

**Marketing workflow examples:**

```
"build our go-to-market plan for Q3"
→ cmo-advisor + marketing-strategy + brand-strategy + /gtm-plan

"audit our paid ads — CPL is too high"
→ ads-manager agent + ads-performance skill + /ads-brief

"calculate our MQL-to-SQL rate and find the drop-off"
→ marketing-analyst + growth-metrics + data-analytics

"write a 5-email welcome sequence for new signups"
→ copywriter agent + email-marketing + copywriting + /email-sequence

"create a content calendar with SEO keywords for next 2 months"
→ content-strategist + content-strategy + seo-strategy + /content-calendar

"review our landing page copy"
→ copywriter agent + copywriting + /copy-review

"build our brand positioning and messaging framework"
→ brand-strategist agent + brand-strategy + /brand-audit
```

---

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

### Data Analytics & Business Intelligence

For data analysts, BI developers, and business analysts who work with data, dashboards, and insights.

> **New Data Pack** (4 skills, 3 agents, 4 commands — ECC quality):  
> `power-bi` · `data-visualization` · `sql-analytics` · `data-analytics`

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| **Exploratory data analysis (EDA)** | `data-analytics` | `data-analyst` | `/eda` |
| **Power BI — DAX, Power Query, star schema** | `power-bi` | `data-analyst` | `/dashboard-audit` |
| **SQL — window functions, CTEs, cohort, funnel** | `sql-analytics` | `sql-analyst` | `/sql-optimize` |
| **Charts & visualizations (matplotlib, Plotly, Tableau)** | `data-visualization` | `data-viz-expert` | `/viz-brief` |
| **Dashboard design & audit** | `data-visualization` + `power-bi` | `data-viz-expert` | `/dashboard-audit` |
| **Cohort & retention analysis** | `sql-analytics` | `sql-analyst` | `/sql-optimize` |
| **Funnel analysis** | `sql-analytics` + `data-analytics` | `data-analyst` | `/eda` |
| **dbt models (staging → mart)** | `sql-analytics` | `sql-analyst` | — |
| **Market sizing & research** | `market-research` (ECC) | `market-researcher` | `/market-analysis` |
| **Business metrics (MRR, CAC, LTV, churn)** | `data-analytics` | `business-analyst` | `/eda` |
| **Competitor intelligence** | `competitive-platform-analysis` (ECC) | `market-researcher` | — |

**Data workflow examples:**

```
"analyze this dataset and find the key insights"
→ data-analyst agent + data-analytics skill + /eda

"optimize this SQL query, it's slow"
→ sql-analyst agent + sql-analytics skill + /sql-optimize

"build a cohort retention table by month"
→ sql-analyst + sql-analytics (Mode 3: cohort analysis)

"create a funnel chart from this data"
→ data-viz-expert + data-visualization + /viz-brief

"audit my Power BI dashboard"
→ data-analyst + power-bi skill + /dashboard-audit

"write a DAX measure for YTD revenue vs same period last year"
→ power-bi skill (Mode 2: time intelligence patterns)

"build an interactive Plotly dashboard"
→ data-viz-expert + data-visualization (Mode 2: Plotly interactive)
```

---

### Automation Engineer — AI Agents

For automation engineers and AI builders who want to automate business processes, build agents, and replace manual work with AI systems.

> **New Automation Pack** (6 skills, 4 agents, 5 commands — ECC quality):  
> `agent-architecture` · `multi-agent-systems` · `n8n-automation` · `model-selection` · `agent-deployment` · `business-automation`

| Task | Skill | Agent | Command |
|------|-------|-------|---------|
| **Design an agent from scratch** | `agent-architecture` | `agent-builder` | `/agent-blueprint` |
| **Multi-agent systems (LangGraph / CrewAI / Claude SDK)** | `multi-agent-systems` | `automation-architect` | `/agent-blueprint` |
| **N8N workflow automation** | `n8n-automation` | `n8n-specialist` | `/biz-automate` |
| **Pick the right AI model** | `model-selection` | `model-advisor` | `/model-compare` |
| **Deploy agent to production** | `agent-deployment` | `agent-builder` | `/agent-deploy` |
| **Automate a business process** | `business-automation` + `n8n-automation` | `automation-architect` | `/biz-automate` |
| **Audit automation opportunities** | `business-automation` | `automation-architect` | `/automation-audit` |
| **Cost comparison across models** | `model-selection` | `model-advisor` | `/model-compare` |
| **"Company of 100 agents" setup** | `business-automation` + `multi-agent-systems` | `automation-architect` | `/biz-automate` |
| **Docker + CI/CD for agents** | `agent-deployment` | `agent-builder` | `/agent-deploy` |
| **Memory systems for agents** | `agent-architecture` | `agent-builder` | — |

**Automation workflow examples:**

```
"I want to automate our lead follow-up process"
→ automation-architect + n8n-automation + /biz-automate

"design an AI agent that reads emails and creates tasks"
→ agent-builder + agent-architecture (ReAct pattern) + /agent-blueprint

"build a multi-agent team: researcher + analyst + writer"
→ automation-architect + multi-agent-systems (CrewAI) + /agent-blueprint

"which model should I use? Claude vs GPT-4o vs Gemini"
→ model-advisor + model-selection + /model-compare

"deploy my Python agent to Railway"
→ agent-builder + agent-deployment + /agent-deploy

"find all manual processes in my business that can be automated"
→ automation-architect + business-automation + /automation-audit

"build N8N workflow for weekly report generation"
→ n8n-specialist + n8n-automation (Mode 2: scheduled report) + /biz-automate
```

**The "Company of 100 Agents" model:**

```
CEO Agent (orchestrator)
├── Marketing Department
│   ├── Content Agent — writes content, posts social
│   ├── Ads Agent — monitors campaigns, adjusts bids
│   └── Analytics Agent — reports weekly metrics
├── Sales Department
│   ├── Lead Research Agent — enriches leads
│   ├── Outreach Agent — sends personalized emails
│   └── CRM Agent — updates deal stages
└── Operations Department
    ├── Customer Support Agent — handles tier 1 tickets
    ├── Report Agent — generates weekly reports
    └── Monitor Agent — alerts on anomalies
```

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

### 📣 Marketing Pack Skills (8 skills)

ECC-quality marketing skills with Skill Stacks, Guardrails, Operating Modes, Formulas, and Quality Gates.

| Skill | What It Does |
|-------|-------------|
| `marketing-strategy` | ICP definition, channel mix scoring, TOFU/MOFU/BOFU mapping, budget allocation, annual calendar |
| `brand-strategy` | Positioning statement, brand pillars, voice/tone spectrum, messaging hierarchy, brand audit |
| `content-strategy` | Content pillars, editorial calendar, content brief template, SEO content planning, distribution matrix |
| `ads-performance` | Google Ads + Meta Ads + TikTok Ads — campaign structure, bidding, CPL/CPA/ROAS formulas, creative testing, campaign audit |
| `growth-metrics` | AARRR, CPL/MQL/SQL/CAC/LTV formulas, MQL scoring model, attribution models, growth dashboard template |
| `copywriting` | AIDA, PAS, 4 U's, headline formulas, landing page structure, ad copy templates, CTA best practices |
| `seo-strategy` | Keyword research process, intent classification, on-page checklist, technical SEO audit, link building, topic clusters |
| `email-marketing` | Welcome sequence, nurture flow, re-engagement, deliverability (SPF/DKIM/DMARC), A/B testing, email KPIs |

---

### 💼 Business Pack Skills (11 skills)

Evidence-grade business skills with ECC-quality Skill Stacks, Guardrails, Operating Modes, and Quality Gates.

| Skill | What It Does |
|-------|-------------|
| `business-strategy` | Porter's Five Forces, Blue Ocean, Ansoff Matrix — strategic analysis with quality gate |
| `data-analytics` | CSV/spreadsheet analysis, KPI library (MRR/CAC/LTV/churn), trend detection, executive summary |
| `market-research` | TAM/SAM/SOM, customer discovery — chains to ECC's `market-research` (ECC) |
| `decision-framework` | RICE, ICE, decision matrix, pre-mortem, first principles — structured decision-making |
| `product-strategy` | PRD, roadmap, PMF — chains to `product-lens` (ECC) for problem validation |
| `okr-planning` | OKR design, cascade, workshop agenda, scoring — with data-backed baselines |
| `pitch-deck` | 10-slide structure, narrative arc, investor Q&A — chains to `market-research` (ECC) |
| `business-model-canvas` | 9-block BMC, unit economics, revenue model — with quality gate |
| `stakeholder-comms` | Executive brief, board update, investor update, change comms |
| `solution-design` | FDE discovery framework, technical proposals, implementation scoping |
| `edutech-strategy` | Bloom's Taxonomy, backward design, LMS selection, Indonesia GTM |

**ECC Business Skills (already included in this repo):**

| Skill | What It Does |
|-------|-------------|
| `market-research` (ECC) | Evidence-first market research — quality gate, source requirements, TAM/SAM/SOM |
| `competitive-platform-analysis` (ECC) | Three-skill competitive pipeline with positioning brief |
| `competitive-report-structure` (ECC) | Decision-grade competitor report assembly |
| `product-lens` (ECC) | Validates the "why" before any PRD — founder diagnostic |
| `deep-research` (ECC) | Multi-source web synthesis with citations |
| `marketing-campaign` (ECC) | End-to-end launch campaign |
| `finance-billing-ops` (ECC) | Revenue/billing truth workflow, MRR reconciliation |

---

### 📊 Data Analytics Pack (4 skills)

ECC-quality data skills with Skill Stack, Guardrails, Operating Modes (with real code), and Quality Gates.

| Skill | What It Does |
|-------|-------------|
| `power-bi` | Star schema design, DAX patterns library (MTD/QTD/YTD/MoM/YoY/churn/Pareto), Power Query ETL, report design rules, calculated columns vs measures |
| `data-visualization` | Chart selection framework, matplotlib/seaborn professional styles, Plotly interactive dashboards, Tableau LOD expressions, Power BI visual selection, 5-second test principle |
| `sql-analytics` | Window functions (ROW_NUMBER/LAG/LEAD/FIRST_VALUE), CTEs, cohort analysis, funnel SQL, dbt models (staging→mart), EXPLAIN ANALYZE query optimization |
| `data-analytics` | CSV/spreadsheet analysis, KPI library (MRR/CAC/LTV/churn/NPS), statistical summaries, trend detection, executive insight summary |

---

### ⚙️ Automation Engineer Pack (6 skills)

Deep, production-grade automation skills from zero to deployed multi-agent company.

| Skill | What It Does |
|-------|-------------|
| `agent-architecture` | ReAct / Plan-and-Execute / Reflexion patterns, memory systems (Buffer/Summary/Vector/Entity), tool design rules, Claude SDK production agent loop, agent evaluation |
| `multi-agent-systems` | LangGraph (StateGraph + conditional routing), CrewAI (role-based teams), Claude Multi-Agent (orchestrator + workers), communication patterns, "Company of 10" template with model tiers |
| `n8n-automation` | Core node types, 4 workflow templates (scheduled report / webhook+AI / lead enrichment / AI agent), Code Node JS, error handling, self-hosted Docker deployment |
| `model-selection` | Full pricing matrix (Claude Sonnet/Haiku/Opus, GPT-4o/mini, Gemini 2.0 Flash/2.5 Pro, Llama 3.3, DeepSeek V3, Qwen2.5), use-case → model mapping, cost calculator, multi-agent tiered strategy, OSS vs paid breakeven, fine-tuning decision |
| `agent-deployment` | Production Dockerfile + docker-compose (FastAPI + Redis), Railway/Render/Fly.io/VPS CLI commands, rate limiting, structlog + Prometheus monitoring, GitHub Actions CI/CD |
| `business-automation` | Automation Readiness Scoring (5 dimensions), department agent templates (Marketing/Sales/Ops), N8N workflow templates, ROI calculator, Phase 1→2→3 implementation roadmap |

---

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

### 📊 Data Analytics Agents

| Agent | When to Use |
|-------|-------------|
| `data-analyst` | EDA, KPI analysis, dashboard audit, Power BI guidance, business metrics (MRR/CAC/LTV) |
| `data-viz-expert` | Chart selection, matplotlib/Plotly/Tableau visualization, dashboard design principles |
| `sql-analyst` | SQL optimization, window functions, cohort/funnel queries, dbt models, query performance |

### ⚙️ Automation Engineer Agents

| Agent | When to Use |
|-------|-------------|
| `automation-architect` | Business process automation, "company of 100 agents" design, ROI assessment, automation roadmap |
| `agent-builder` | Build agents from scratch (ReAct/Plan-Execute/Reflexion), tool design, Claude SDK implementation, production deployment |
| `n8n-specialist` | N8N workflow design, node configuration, AI agent workflows, error handling, self-hosting setup |
| `model-advisor` | Model selection (Claude vs GPT-4o vs Gemini vs OSS), cost projections, multi-agent tiered strategy, fine-tuning assessment |

---

### 📣 Marketing Agents

| Agent | When to Use |
|-------|-------------|
| `cmo-advisor` | Marketing strategy, GTM, budget decisions, board-level marketing questions |
| `brand-strategist` | Brand positioning, messaging framework, brand audit, rebranding |
| `growth-marketer` | Funnel optimization, growth experiments, CPL/CAC analysis, channel scaling |
| `ads-manager` | Google/Meta/TikTok campaign setup, audit, creative testing, ROAS optimization |
| `content-strategist` | Content calendar, pillar strategy, SEO content planning, content audit |
| `copywriter` | Ad copy, landing page copy, email sequences, social media copy |
| `marketing-analyst` | Campaign performance analysis, attribution, funnel diagnosis, executive dashboard |
| `social-media-strategist` | Platform strategy, organic social calendar, community management, social KPIs |

### 💼 Business & Strategy Agents

| Agent | When to Use |
|-------|-------------|
| `ceo-advisor` | Strategic decisions, competitive positioning, fundraising, board prep |
| `product-manager` | PRD, roadmap prioritization, feature discovery, OKR alignment |
| `business-analyst` | Requirements gathering, process mapping, gap analysis, specifications |
| `solution-engineer` | Client discovery, technical proposals, FDE engagements, scoping |
| `market-researcher` | Market sizing, competitor intelligence, customer insight synthesis |
| `pitch-coach` | Investor deck review, presentation prep, demo day coaching |
| `okr-coach` | OKR drafting, mid-quarter review, end-of-quarter retrospective |
| `edutech-specialist` | Curriculum design, LMS evaluation, edtech product strategy |

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

### 📊 Data Analytics Commands

| Command | Function |
|---------|---------|
| `/eda` | Full exploratory data analysis — data quality audit → statistical summary → distributions → correlations → time series → anomaly detection → business insight summary |
| `/viz-brief` | Chart selection + complete Python code (matplotlib or Plotly) + design notes + accessible color palette |
| `/sql-optimize` | Plain English translation → issues found → rewritten query → EXPLAIN ANALYZE → before/after performance comparison |
| `/dashboard-audit` | Dashboard audit across 4 dimensions: design quality / data accuracy / business usefulness / Power BI specifics |

---

### ⚙️ Automation Engineer Commands

| Command | Function |
|---------|---------|
| `/agent-blueprint` | Complete agent spec — brain/memory/tools/planning/error handling/evaluation/test cases + production Python code |
| `/automation-audit` | Process inventory → readiness scoring (5 dimensions) → ROI estimate → automation roadmap → agent team design → risk register |
| `/model-compare` | Comparison table (cost/context/speed/strengths) + monthly cost projection + recommendation + open source option + fine-tuning assessment |
| `/agent-deploy` | Dockerfile + docker-compose + platform CLI commands (Railway/Render/Fly.io/VPS) + security checklist + monitoring setup + GitHub Actions CI/CD |
| `/biz-automate` | Full process map → automation design → N8N workflow or Python agent code → ROI summary → go-live checklist |

---

### 📣 Marketing Commands

| Command | Function |
|---------|---------|
| `/marketing-plan` | Full marketing strategy — ICP, channels, TOFU/MOFU/BOFU, budget, 90-day plan |
| `/brand-audit` | Brand consistency, clarity, and differentiation audit with fix list |
| `/ads-brief` | Complete paid ads campaign brief — structure, targeting, creative, bidding, tracking |
| `/content-calendar` | Content calendar (4–8 weeks) with pillars, keywords, format, channel, CTA |
| `/copy-review` | Marketing copy review — 4 U's, framework check, brand voice, specific rewrites |
| `/growth-audit` | Full funnel audit — CPL/MQL/SQL/CAC/LTV + top 3 growth experiments |
| `/gtm-plan` | Go-to-market plan — positioning, channels, launch timeline, success metrics |
| `/campaign-brief` | Integrated marketing campaign brief — objective, messaging, creative, channel plan |
| `/seo-audit` | SEO audit — technical, on-page, keyword gaps, content opportunities |
| `/email-sequence` | Complete email sequence — welcome / nurture / re-engagement with full copy |

---

### 💼 Business Commands

| Command | Function |
|---------|---------|
| `/biz-plan` | Full business plan — market, model, strategy, financials |
| `/market-analysis` | Market research + sizing + competitor landscape |
| `/okr-workshop` | Facilitate OKR setting session |
| `/pitch-deck` | Build or review an investor pitch deck |
| `/decision-matrix` | Structured decision with weighted criteria |
| `/solution-proposal` | Technical solution proposal for a client |
| `/product-roadmap` | Build or review a product roadmap |
| `/exec-brief` | Executive one-pager for stakeholders |
| `/bmc` | Build a Business Model Canvas |
| `/jtbd` | Jobs to Be Done analysis |

---

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

### Data Analytics Quick Start

```
Step 1: "analyze this CSV"                   → /eda (full EDA report)
Step 2: "optimize the SQL query for this"    → /sql-optimize
Step 3: "visualize the cohort retention"     → /viz-brief
Step 4: "audit my Power BI dashboard"        → /dashboard-audit
```

### Automation Quick Start

```
Step 1: "audit which processes I can automate"      → /automation-audit
Step 2: "compare models for this use case"           → /model-compare
Step 3: "design the agent that handles [process]"   → /agent-blueprint
Step 4: "build the N8N workflow"                     → /biz-automate
Step 5: "deploy to production"                       → /agent-deploy
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
