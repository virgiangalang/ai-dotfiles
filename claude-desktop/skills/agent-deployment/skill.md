---
name: agent-deployment
description: AI agent production deployment specialist covering Docker containerization, hosting options (Railway, Render, Fly.io, VPS), monitoring, cost tracking, API key management, rate limiting, and scaling patterns. Use when taking an AI agent from working prototype to production.
---

# Agent Deployment

## Skill Stack

- `agent-architecture` — agent must be designed before deploying
- `multi-agent-systems` — orchestrated systems have additional deployment complexity
- `model-selection` — model choice affects deployment cost and latency
- `n8n-automation` — when N8N is the orchestration layer being deployed

## Guardrails

- Never commit API keys to git — use environment variables and a secrets manager
- Always add request rate limiting before public exposure — LLMs can get expensive fast
- Never skip health check endpoints — you need to know if the agent is alive
- Always log every LLM call with cost — without logging you can't debug or control spend
- Test the full deployment in staging with real traffic before going to production
- Set hard spend limits on all LLM API keys — one bug can cost hundreds of dollars overnight

---

## Operating Modes

### Mode 1: Containerize with Docker

**Dockerfile (FastAPI + LangChain agent):**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install dependencies first (cached layer)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Non-root user for security
RUN useradd -m -u 1000 appuser && chown -R appuser /app
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**requirements.txt:**
```
fastapi==0.115.0
uvicorn==0.32.0
langchain==0.3.0
langchain-anthropic==0.2.0
anthropic==0.40.0
python-dotenv==1.0.0
pydantic==2.9.0
redis==5.2.0          # for rate limiting + caching
structlog==24.4.0     # structured logging
prometheus-client==0.21.0  # metrics
```

**main.py — production FastAPI agent:**
```python
from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import structlog
import time

from agent import run_agent
from middleware import RateLimiter, CostTracker

logger = structlog.get_logger()
app = FastAPI(title="AI Agent API", version="1.0.0")

# CORS — restrict in production
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://yourdomain.com"],  # NOT ["*"] in production
    allow_methods=["POST"],
    allow_headers=["Authorization", "Content-Type"],
)

class AgentRequest(BaseModel):
    message: str
    session_id: str | None = None
    max_tokens: int = 2000

class AgentResponse(BaseModel):
    response: str
    tokens_used: int
    cost_usd: float
    latency_ms: int

@app.get("/health")
async def health():
    return {"status": "ok", "timestamp": time.time()}

@app.post("/agent", response_model=AgentResponse)
async def agent_endpoint(
    request: AgentRequest,
    limiter: RateLimiter = Depends(),
):
    start = time.time()
    log = logger.bind(session_id=request.session_id)

    try:
        result = await run_agent(request.message, request.session_id)
        latency = int((time.time() - start) * 1000)

        log.info("agent_success",
                 tokens=result.tokens_used,
                 cost_usd=result.cost_usd,
                 latency_ms=latency)

        return AgentResponse(
            response=result.text,
            tokens_used=result.tokens_used,
            cost_usd=result.cost_usd,
            latency_ms=latency
        )

    except Exception as e:
        log.error("agent_error", error=str(e))
        raise HTTPException(status_code=500, detail="Agent error")
```

**docker-compose.yml (full stack):**
```yaml
version: '3.8'
services:
  agent:
    build: .
    ports:
      - "8000:8000"
    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - REDIS_URL=redis://redis:6379
      - LOG_LEVEL=INFO
      - MAX_TOKENS_PER_HOUR=100000
    depends_on:
      - redis
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 512M

  redis:
    image: redis:7-alpine
    restart: unless-stopped
    volumes:
      - redis_data:/data

  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

volumes:
  redis_data:
```

---

### Mode 2: Hosting Options

**Railway.app (recommended for most projects):**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and init
railway login
railway init

# Deploy from Dockerfile
railway up

# Set environment variables
railway variables set ANTHROPIC_API_KEY=sk-ant-...
railway variables set REDIS_URL=${{Redis.REDIS_URL}}

# Add Redis plugin: Railway dashboard → Add Service → Redis

# Custom domain
railway domain add yourdomain.com
```
Cost: ~$5-20/month, sleeps after inactivity on free tier.

**Render.com:**
```yaml
# render.yaml — deploy from config
services:
  - type: web
    name: ai-agent
    env: docker
    plan: starter  # $7/month
    envVars:
      - key: ANTHROPIC_API_KEY
        sync: false  # set in dashboard
    healthCheckPath: /health
    autoDeploy: true
```

**Fly.io:**
```toml
# fly.toml
app = "my-ai-agent"
primary_region = "sin"  # Singapore — closest to Indonesia

[build]
  dockerfile = "Dockerfile"

[[services]]
  protocol = "tcp"
  internal_port = 8000

  [[services.ports]]
    port = 443
    handlers = ["tls", "http"]

  [services.concurrency]
    type = "requests"
    hard_limit = 25
    soft_limit = 20

[env]
  LOG_LEVEL = "INFO"
```
```bash
fly launch
fly secrets set ANTHROPIC_API_KEY=sk-ant-...
fly deploy
```

**VPS (best value at scale — DigitalOcean/Hetzner):**
```bash
# Hetzner CX21: 2 vCPU, 4GB RAM, $5/month → runs 3-4 containers easily

# Setup on VPS
curl -fsSL https://get.docker.com | sh
mkdir -p /opt/agent && cd /opt/agent

# Copy files
scp docker-compose.yml .env user@server:/opt/agent/

# Run
docker compose up -d

# Nginx reverse proxy
apt install nginx
cat > /etc/nginx/sites-available/agent << 'EOF'
server {
    server_name agent.yourdomain.com;
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
EOF
certbot --nginx -d agent.yourdomain.com
```

---

### Mode 3: Rate Limiting & Cost Control

```python
# middleware.py — rate limiting + cost tracking
import redis
import time
from fastapi import HTTPException, Request

class RateLimiter:
    def __init__(self):
        self.redis = redis.from_url(settings.REDIS_URL)
    
    async def __call__(self, request: Request):
        client_ip = request.client.host
        key = f"rate_limit:{client_ip}:{int(time.time() // 60)}"  # per minute
        
        count = self.redis.incr(key)
        self.redis.expire(key, 60)
        
        if count > 20:  # 20 requests per minute per IP
            raise HTTPException(status_code=429, detail="Rate limit exceeded. Wait 60s.")

class CostTracker:
    LIMITS = {
        "hourly_tokens": 500_000,    # ~$7.50 claude-haiku max per hour
        "daily_usd": 50.00,          # hard daily spend cap
    }
    
    def __init__(self):
        self.redis = redis.from_url(settings.REDIS_URL)
    
    def record_cost(self, tokens: int, cost_usd: float):
        hour_key = f"cost:hour:{int(time.time() // 3600)}"
        day_key  = f"cost:day:{int(time.time() // 86400)}"
        
        self.redis.incrbyfloat(hour_key, cost_usd)
        self.redis.incrbyfloat(day_key, cost_usd)
        self.redis.expire(hour_key, 7200)
        self.redis.expire(day_key, 172800)
    
    def check_limits(self) -> bool:
        day_key = f"cost:day:{int(time.time() // 86400)}"
        daily_spend = float(self.redis.get(day_key) or 0)
        
        if daily_spend >= self.LIMITS["daily_usd"]:
            raise HTTPException(status_code=503, detail="Daily cost limit reached")
```

---

### Mode 4: Logging & Monitoring

```python
# Structured logging — every LLM call gets logged
import structlog

structlog.configure(
    processors=[
        structlog.processors.TimeStamper(fmt="iso"),
        structlog.processors.add_log_level,
        structlog.processors.JSONRenderer()
    ]
)

logger = structlog.get_logger()

# In your agent wrapper:
def log_llm_call(model, input_tokens, output_tokens, cost_usd, latency_ms, success):
    logger.info("llm_call",
        model=model,
        input_tokens=input_tokens,
        output_tokens=output_tokens,
        cost_usd=round(cost_usd, 6),
        latency_ms=latency_ms,
        success=success
    )

# Prometheus metrics
from prometheus_client import Counter, Histogram, Gauge

llm_calls_total  = Counter('llm_calls_total', 'Total LLM calls', ['model', 'status'])
llm_cost_usd     = Counter('llm_cost_usd_total', 'Total LLM cost in USD', ['model'])
llm_latency_ms   = Histogram('llm_latency_ms', 'LLM call latency', ['model'])
active_sessions  = Gauge('active_sessions', 'Current active agent sessions')
```

**Log analysis queries (for Grafana/Loki):**
```
# Average cost per request (last 24h)
{app="ai-agent"} | json | avg(cost_usd)

# Error rate
rate({app="ai-agent", level="error"}[5m])

# P95 latency
quantile_over_time(0.95, {app="ai-agent"} | json | unwrap latency_ms [1h])
```

---

### Mode 5: CI/CD Pipeline

```yaml
# .github/workflows/deploy.yml
name: Deploy AI Agent

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: '3.11' }
      - run: pip install -r requirements.txt
      - run: pytest tests/ -v --timeout=30
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY_TEST }}

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy to Railway
        run: |
          npm install -g @railway/cli
          railway up --service ai-agent
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}
      - name: Notify Slack
        run: |
          curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
            -d '{"text": "✅ AI Agent deployed successfully"}'
```

---

## Quality Gate

Before calling production deployment done:
- [ ] API keys in environment variables only — git grep for any hardcoded keys
- [ ] Health check endpoint working and monitored
- [ ] Rate limiting configured (per IP, per user)
- [ ] Hard spend cap set on LLM API keys (Anthropic console → Usage limits)
- [ ] Every LLM call logged with tokens + cost
- [ ] Alerting set up: error spike → Slack/PagerDuty
- [ ] Tested at 10× expected traffic to verify no crashes
- [ ] Rollback plan: previous Docker image tagged and ready
- [ ] HTTPS only — no HTTP in production
- [ ] CORS configured to specific origins, not wildcard
