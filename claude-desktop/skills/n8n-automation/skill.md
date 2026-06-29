---
name: n8n-automation
description: N8N workflow automation specialist covering nodes, triggers, AI agent workflows, error handling, credentials, and self-hosted deployment. Also covers Make.com patterns. Use when building no-code/low-code automation workflows that connect apps, trigger on events, and run AI-powered processes.
---

# N8N Automation

## Skill Stack

- `multi-agent-systems` — when N8N orchestrates AI agents as part of the workflow
- `model-selection` — choose the right AI model for each N8N AI node
- `agent-deployment` — when the N8N instance itself needs to be deployed
- `business-automation` — map business processes to N8N workflows

## Guardrails

- Never store API keys in workflow nodes — always use N8N credentials system
- Always add error handling to workflows that touch external APIs — they WILL fail
- Test with small data sets before enabling triggers on live data
- Never delete a working workflow — disable it and add "(DEPRECATED)" to the name
- For workflows that send emails/Slack/post to social — add a human approval step
- Large datasets must be processed with batching — N8N has memory limits per execution

---

## Operating Modes

### Mode 1: Core Concepts

**Workflow anatomy:**
```
Trigger Node → Transform Nodes → Action Nodes
    │                │                │
    │           Filter/If          Send email
    │           Set fields         Post to Slack
    │           HTTP Request       Write to DB
    │           Code node          Generate PDF
    └─── runs on: schedule / webhook / manual / event
```

**Key node types:**

| Category | Nodes | Use for |
|---|---|---|
| **Triggers** | Schedule, Webhook, Email Trigger, RSS | Start the workflow |
| **Data** | HTTP Request, GraphQL, FTP | Fetch/send data |
| **Transform** | Set, Code, Function, Filter, Switch, Merge | Shape the data |
| **AI** | AI Agent, OpenAI, Anthropic, Langchain | AI processing |
| **Apps** | Google Sheets, Notion, Airtable, HubSpot | App integrations |
| **Comms** | Gmail, Slack, Telegram, WhatsApp | Send messages |
| **Flow** | If, Switch, Loop, Wait, Merge | Control flow |

---

### Mode 2: Essential Workflow Patterns

**Pattern 1: Scheduled data pull → process → report**
```
Schedule Trigger (daily 9am)
    → HTTP Request (fetch sales data from API)
    → Code Node (calculate KPIs)
    → AI Node (generate insight summary)
    → Gmail (send report to team)
    → Google Sheets (log to spreadsheet)
```

**Pattern 2: Webhook → AI classification → route**
```
Webhook Trigger (receives customer inquiry)
    → AI Agent (classify: billing / technical / general)
    → Switch Node
        → billing:   HubSpot (create ticket in billing queue)
        → technical: Slack (alert technical team)
        → general:   Gmail (auto-reply with FAQ)
```

**Pattern 3: New lead → enrich → CRM**
```
Webhook (form submission)
    → HTTP Request (enrich with Clearbit / Hunter.io)
    → AI Node (score lead quality 1-10)
    → If Node (score >= 7)
        → HubSpot (create deal + contact)
        → Slack (notify sales rep)
        → Gmail (personalized welcome email)
    → else:
        → Google Sheets (log low-score leads for nurture)
```

**Pattern 4: AI Agent with tools (N8N 1.x)**
```
Chat Trigger (user message)
    → AI Agent Node
        ├── Tool: HTTP Request (query internal API)
        ├── Tool: Google Sheets (read/write data)
        ├── Tool: Send Email (compose and send)
        └── Tool: Code Node (custom computation)
    → Set Node (format response)
    → Respond to Webhook
```

---

### Mode 3: N8N Node Reference

**HTTP Request node — call any API:**
```json
{
    "method": "POST",
    "url": "https://api.example.com/v1/leads",
    "authentication": "Header Auth",
    "headerAuth": {
        "name": "Authorization",
        "value": "Bearer {{ $credentials.apiToken }}"
    },
    "sendBody": true,
    "bodyContentType": "JSON",
    "jsonBody": {
        "email": "{{ $json.email }}",
        "name": "{{ $json.name }}",
        "source": "n8n_workflow"
    }
}
```

**Code Node (JavaScript) — custom transformation:**
```javascript
// Access input data
const items = $input.all();

// Process each item
const results = items.map(item => {
    const data = item.json;
    
    // Custom logic
    const score = calculateLeadScore(data);
    const formattedDate = new Date(data.created_at).toISOString().split('T')[0];
    
    return {
        json: {
            ...data,
            lead_score: score,
            formatted_date: formattedDate,
            is_qualified: score >= 7,
        }
    };
});

return results;

// Helper function
function calculateLeadScore(data) {
    let score = 0;
    if (data.company_size > 50) score += 3;
    if (data.job_title.includes('Director') || data.job_title.includes('VP')) score += 3;
    if (data.industry === 'Technology') score += 2;
    if (data.demo_requested) score += 2;
    return Math.min(score, 10);
}
```

**If Node — conditional branching:**
```
Condition: {{ $json.lead_score }} >= 7
→ True branch: qualified lead flow
→ False branch: nurture flow

Multiple conditions:
- {{ $json.status }} equals "active" AND
- {{ $json.revenue }} > 1000000
→ True: VIP customer flow
```

**Set Node — add/transform fields:**
```javascript
// Fields to set:
message: "Hello {{ $json.first_name }}, thank you for your interest in {{ $workflow.name }}"
timestamp: {{ $now.toISO() }}
workflow_id: {{ $workflow.id }}
processed: true
full_name: {{ $json.first_name + ' ' + $json.last_name }}
```

**Loop Over Items — process array one-by-one:**
```
Split in Batches Node: batch size 10
    → Process each item (HTTP Request, AI, etc.)
    → Merge Node (collect all results)

// Use for: sending 1000 emails, processing 500 rows, enriching a list
```

---

### Mode 4: AI Agent Workflow (Advanced)

**Full AI agent with memory in N8N:**
```
Chat Trigger
    │
    ▼
Set Node (prepare input)
    │
    ▼
AI Agent Node
    ├── Model: Claude Haiku (fast, cheap for chat)
    ├── System Prompt: "You are a customer support agent for [Company].
    │                  You have access to order lookup and FAQ tools."
    ├── Memory: Window Buffer Memory (last 10 messages)
    └── Tools:
        ├── HTTP Request Tool → GET /api/orders/{order_id}
        ├── HTTP Request Tool → GET /api/faq?query={question}
        └── Slack Tool → post_message to #escalations
    │
    ▼
If Node (escalate?)
    ├── contains "speak to human" → Slack alert
    └── else → respond to user
```

**Agent system prompt template:**
```
You are [NAME], an AI agent for [COMPANY].

Your capabilities:
- Look up customer orders using the get_order tool
- Search the FAQ using the search_faq tool
- Escalate to human using the escalate tool

Rules:
1. Always verify order ID before providing order details
2. Never invent information — use tools for facts
3. If you cannot resolve in 3 tool calls, escalate to human
4. Respond in Bahasa Indonesia if customer writes in Indonesian
```

---

### Mode 5: Error Handling

**Add to every production workflow:**
```
Every external HTTP Request:
    → Settings: "Continue on Fail" = ON
    → After node: IF node checking {{ $json.error }} exists
        → True: Error handler (Slack alert + log to Sheets)
        → False: Continue normal flow

Workflow-level error trigger:
    Error Trigger Node (catches any uncaught error)
        → Set Node (format error message)
        → Slack (alert #ops-alerts channel)
        → Google Sheets (log error: timestamp, workflow, node, error message)

Retry pattern:
    HTTP Request → If (error?) → Wait 30s → HTTP Request (retry)
    After 3 retries → Error handler
```

**Error notification template:**
```javascript
// Code node for error formatting
const error = $json.error || {};
return [{
    json: {
        alert: "⚠️ N8N Workflow Error",
        workflow: $workflow.name,
        node: $node.name,
        error_message: error.message || "Unknown error",
        error_code: error.code,
        timestamp: new Date().toISOString(),
        execution_id: $execution.id,
        action: "Check N8N dashboard for full trace",
    }
}];
```

---

### Mode 6: Self-Hosted N8N Deployment

**Docker Compose (production):**
```yaml
version: '3.8'
services:
  n8n:
    image: n8nio/n8n:latest
    restart: always
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=${N8N_PASSWORD}
      - N8N_ENCRYPTION_KEY=${N8N_ENCRYPTION_KEY}
      - N8N_HOST=${DOMAIN}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://${DOMAIN}/
      - EXECUTIONS_PROCESS=main
      - DB_TYPE=postgresdb
      - DB_POSTGRESDB_HOST=postgres
      - DB_POSTGRESDB_PORT=5432
      - DB_POSTGRESDB_DATABASE=n8n
      - DB_POSTGRESDB_USER=n8n
      - DB_POSTGRESDB_PASSWORD=${DB_PASSWORD}
    volumes:
      - n8n_data:/home/node/.n8n
    depends_on:
      - postgres

  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_DB: n8n
      POSTGRES_USER: n8n
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  n8n_data:
  postgres_data:
```

**Recommended hosting:**
- Railway.app — easiest, one-click deploy, ~$5-10/month
- Render.com — free tier available, good for low-volume
- VPS (DigitalOcean/Hetzner) — best value at scale, $6/month droplet
- N8N Cloud — managed, no maintenance, starts $20/month

---

## Quality Gate

Before enabling a production N8N workflow:
- [ ] All API credentials stored in N8N credentials, never in node parameters
- [ ] Error handler added (Error Trigger + Slack alert)
- [ ] "Continue on Fail" enabled for all HTTP Request nodes
- [ ] Tested with real data (not just example data)
- [ ] For loops/batches: tested with large dataset to check memory usage
- [ ] Human approval step for irreversible actions (emails, posts, payments)
- [ ] Workflow documented: name is descriptive, notes added to complex nodes
- [ ] Production trigger vs. test trigger confirmed (don't leave test webhook active)
