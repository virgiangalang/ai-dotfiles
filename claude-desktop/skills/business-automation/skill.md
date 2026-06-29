---
name: business-automation
description: Business automation strategy specialist. Maps business processes to AI agent teams. Covers department-by-department automation (Marketing, Sales, Ops, Finance, HR, Support), process identification, agent team design, ROI calculation, and the "company of 100 agents" architecture. Use when designing AI automation for an entire business or department.
---

# Business Automation

## Skill Stack

- `multi-agent-systems` — design the agent teams for each department
- `n8n-automation` — N8N as the orchestration layer connecting agents to apps
- `model-selection` — right model for each agent role (cost vs. quality)
- `agent-architecture` — design each individual agent
- `agent-deployment` — deploy the automation infrastructure

## Guardrails

- Never automate a process you don't fully understand — map it manually first
- Never automate communication with real customers without human review for first 2 weeks
- Always start with one department, prove ROI, then expand — big bang automation fails
- Every automated action that touches money, legal, or customers needs a human in the loop
- Build the escape hatch first — every automation needs a manual override
- Measure before automating — you can't calculate ROI without a baseline

---

## The "Company of 100 Agents" Model

A single person + AI agents can operate like a company with 100 employees. The key is mapping each business function to a specialized agent team.

```
                        CEO (human)
                            │
            ┌───────────────┼───────────────┐
            ▼               ▼               ▼
       MARKETING          SALES           OPS
       Agent Team        Agent Team      Agent Team
            │               │               │
    ┌───────┤       ┌───────┤       ┌───────┤
    │       │       │       │       │       │
  CMO    Content  SDR    Account  Ops    Finance
 Agent  Agents  Agents   Exec   Agent   Agent
                         Agents
```

---

## Operating Modes

### Mode 1: Process Identification Framework

Before building agents, map the current process:

**Automation Readiness Score (1-5 per dimension):**
```
Score each process:
1. Repetitive (1=unique each time, 5=identical every time)
2. Rule-based (1=requires judgment, 5=follows clear rules)
3. Data-driven (1=subjective, 5=input→output deterministic)
4. Volume (1=<10/month, 5=>100/day)
5. Time-sensitive (1=whenever, 5=must be instant)

Total ≥ 15 → automate fully
Total 10-14 → automate with human review
Total < 10 → assist, don't automate
```

**High-ROI automation targets:**
```
✓ Data entry and transfer (between apps)
✓ Report generation (weekly/monthly)
✓ Email classification and routing
✓ Lead enrichment and scoring
✓ Invoice processing
✓ Social media posting
✓ Customer onboarding sequences
✓ Inventory alerts
✓ Meeting scheduling
✓ Support ticket categorization
✓ Content repurposing (blog → LinkedIn → newsletter)
✓ Competitive monitoring
```

---

### Mode 2: Department-by-Department Agent Teams

**MARKETING TEAM (4 agents):**
```python
MARKETING_AGENTS = {
    "content_agent": {
        "job": "Write blog posts, social media, email newsletters",
        "model": "claude-haiku-4-5",
        "tools": ["web_search", "google_docs_write", "image_prompt_gen"],
        "triggers": ["weekly_schedule", "topic_request"],
        "output": "Draft content in Google Docs + Notion calendar entry"
    },
    "seo_monitor": {
        "job": "Track keyword rankings, flag drops, suggest improvements",
        "model": "gpt-4o-mini",
        "tools": ["ahrefs_api", "google_search_console", "google_sheets"],
        "triggers": ["daily_schedule"],
        "output": "Weekly SEO report in Slack"
    },
    "ad_performance": {
        "job": "Pull ad metrics, calculate ROAS, flag underperforming campaigns",
        "model": "claude-haiku-4-5",
        "tools": ["meta_ads_api", "google_ads_api", "google_sheets"],
        "triggers": ["daily_9am"],
        "output": "Daily ad performance Slack message + optimization suggestions"
    },
    "competitor_monitor": {
        "job": "Track competitor pricing, launches, content, job postings",
        "model": "gpt-4o-mini",
        "tools": ["web_scraper", "google_alerts_api", "notion_write"],
        "triggers": ["weekly_schedule"],
        "output": "Competitor intel brief in Notion"
    }
}
```

**SALES TEAM (4 agents):**
```python
SALES_AGENTS = {
    "lead_qualifier": {
        "job": "Score incoming leads, enrich with company data, route to right rep",
        "model": "claude-haiku-4-5",
        "tools": ["clearbit_api", "hunter_api", "hubspot_write", "slack_notify"],
        "triggers": ["webhook_new_lead"],
        "output": "Enriched lead in HubSpot + Slack notification to rep"
    },
    "outreach_writer": {
        "job": "Write personalized cold emails and LinkedIn messages based on prospect profile",
        "model": "claude-sonnet-4-6",
        "tools": ["web_search", "linkedin_search", "hubspot_read"],
        "triggers": ["new_lead_assigned"],
        "output": "3 email variants in HubSpot sequence, draft LinkedIn message"
    },
    "proposal_agent": {
        "job": "Generate custom proposals based on discovered pain points",
        "model": "claude-sonnet-4-6",
        "tools": ["hubspot_read", "google_docs_write", "web_search"],
        "triggers": ["deal_stage_proposal"],
        "output": "Custom proposal Google Doc, sent to prospect"
    },
    "pipeline_reporter": {
        "job": "Weekly sales pipeline summary, deal health check, forecast",
        "model": "gpt-4o-mini",
        "tools": ["hubspot_read", "google_sheets", "slack_send"],
        "triggers": ["friday_4pm"],
        "output": "Weekly pipeline report in Slack"
    }
}
```

**OPERATIONS TEAM (4 agents):**
```python
OPS_AGENTS = {
    "invoice_processor": {
        "job": "Extract data from incoming invoices, match to POs, flag discrepancies",
        "model": "claude-haiku-4-5",
        "tools": ["email_read", "pdf_extract", "google_sheets", "slack_alert"],
        "triggers": ["new_email_attachment"],
        "output": "Invoice data in Google Sheets + Slack alert if mismatch"
    },
    "support_classifier": {
        "job": "Classify support tickets, draft responses, route complex issues",
        "model": "claude-haiku-4-5",
        "tools": ["zendesk_read", "zendesk_write", "knowledge_base_search"],
        "triggers": ["new_support_ticket"],
        "output": "Classified ticket + draft response in Zendesk"
    },
    "reporting_agent": {
        "job": "Generate weekly business metrics report",
        "model": "claude-sonnet-4-6",
        "tools": ["google_analytics", "stripe_api", "hubspot_read", "google_slides"],
        "triggers": ["monday_8am"],
        "output": "Weekly business review Google Slides"
    },
    "onboarding_agent": {
        "job": "Run customer onboarding sequence — welcome, setup, check-ins",
        "model": "claude-haiku-4-5",
        "tools": ["gmail_send", "calendar_create", "notion_create", "hubspot_update"],
        "triggers": ["new_customer_payment"],
        "output": "Welcome email + onboarding tasks in Notion + Day-3 check-in scheduled"
    }
}
```

---

### Mode 3: N8N Workflow Templates for Business

**Lead generation pipeline (N8N workflow):**
```
Schedule: Daily 8am
│
├── HTTP Request: Scrape target company list (Apollo.io API)
├── Loop: For each company
│     ├── HTTP Request: Clearbit enrichment
│     ├── AI Node: Qualify lead (Claude Haiku)
│     │     Prompt: "Score this company 1-10 for fit with our ICP: {company_data}"
│     ├── If: score >= 7
│     │     ├── HubSpot: Create contact + deal
│     │     ├── AI Node: Write personalized email (Claude Sonnet)
│     │     └── Gmail: Queue outreach email (draft, not send)
│     └── Else: Google Sheets: Log for future nurture
└── Slack: "Today's qualified leads: {count}"
```

**Customer support automation (N8N workflow):**
```
Webhook Trigger: New Zendesk ticket
│
├── AI Agent Node (Claude Haiku + tools):
│     System: "You are a support agent. Use search_kb to find answers."
│     Tools:
│         search_kb: HTTP GET /api/knowledge-base?q={query}
│         get_order: HTTP GET /api/orders/{order_id}
│
├── If: AI confident (response contains "CONFIDENT")
│     ├── Zendesk: Post AI response as draft (not public)
│     └── Slack: "AI drafted response for ticket #{id} — please review"
│
└── Else: Escalate
      ├── Zendesk: Tag "needs-human"
      └── Slack: Alert support team
```

---

### Mode 4: ROI Calculation

```python
def calculate_automation_roi(
    task_name: str,
    hours_per_month: float,
    hourly_rate_usd: float,
    ai_cost_per_month_usd: float,
    quality_improvement_pct: float = 0,
    speed_multiplier: float = 1.0
) -> dict:
    
    current_cost = hours_per_month * hourly_rate_usd
    automated_cost = ai_cost_per_month_usd
    monthly_savings = current_cost - automated_cost
    annual_savings = monthly_savings * 12
    
    # Time value recovered (could be spent on higher-value work)
    hours_recovered_monthly = hours_per_month * (1 - 1/speed_multiplier)
    
    return {
        "task": task_name,
        "current_monthly_cost": f"${current_cost:,.0f}",
        "automated_monthly_cost": f"${automated_cost:,.0f}",
        "monthly_savings": f"${monthly_savings:,.0f}",
        "annual_savings": f"${annual_savings:,.0f}",
        "roi_pct": f"{(monthly_savings / automated_cost * 100):,.0f}%",
        "hours_recovered_monthly": f"{hours_recovered_monthly:.0f}h",
        "quality_improvement": f"+{quality_improvement_pct}%"
    }

# Example calculations:
print(calculate_automation_roi(
    task_name="Weekly marketing report",
    hours_per_month=8,
    hourly_rate_usd=50,
    ai_cost_per_month_usd=5,
    speed_multiplier=10
))
# current_cost: $400, automated: $5, savings: $395/month ($4,740/yr), ROI: 7,900%

print(calculate_automation_roi(
    task_name="Lead enrichment (100 leads/month)",
    hours_per_month=10,
    hourly_rate_usd=30,
    ai_cost_per_month_usd=20,
    quality_improvement_pct=15
))
# current_cost: $300, automated: $20, savings: $280/month ($3,360/yr)
```

---

### Mode 5: Implementation Roadmap

**Phase 1 — Quick wins (Week 1-2):**
```
✓ Lead enrichment automation (Apollo → Clearbit → HubSpot)
✓ Weekly report generation (data → AI summary → Slack/email)
✓ Support ticket classification and draft responses
✓ Social media content scheduling
```

**Phase 2 — Core processes (Week 3-6):**
```
✓ Full sales outreach sequence (qualify → enrich → write → schedule)
✓ Customer onboarding automation
✓ Invoice processing and matching
✓ Competitor monitoring dashboard
```

**Phase 3 — Advanced intelligence (Month 2-3):**
```
✓ AI agent with memory for ongoing customer relationships
✓ Cross-department data flows (marketing → sales → ops)
✓ Predictive alerts (churn risk, inventory low, deal stalled)
✓ Custom LLM fine-tuned on your business data
```

**Success metrics:**
```
Week 1: Time saved per week (target: >5 hours)
Month 1: Cost per automated task vs. manual
Month 3: Revenue influenced by automation
Month 6: FTE equivalent capacity added
```

---

## Quality Gate

Before deploying business automation:
- [ ] Process fully documented manually before automation
- [ ] Automation Readiness Score ≥ 10 for the process
- [ ] ROI calculated with conservative assumptions
- [ ] Manual override exists for every automated action
- [ ] Human review step for first 50 executions of customer-facing automations
- [ ] Error alerting in place (Slack + log)
- [ ] Legal/compliance review for automations touching contracts, payments, PII
- [ ] Rollback plan: how to turn off automation if it misbehaves
