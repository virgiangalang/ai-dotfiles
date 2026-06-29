---
description: Deploy an AI agent to production. Covers Dockerfile, hosting selection (Railway/Render/Fly.io/VPS), rate limiting, cost monitoring, logging, health checks, and CI/CD setup.
---

Load the `agent-deployment` skill. Activate the `agent-builder` agent.

Deploy the described AI agent to production. First confirm:
1. Language / framework (Python FastAPI? Node.js? Other?)
2. Hosting preference (Railway / Render / Fly.io / VPS / cloud)?
3. Expected traffic (requests/day)?
4. Need for persistent storage (Redis / PostgreSQL)?
5. Monthly budget for hosting?

Then deliver:

**Dockerfile**
Production-ready Dockerfile with:
- Slim base image
- Non-root user
- Health check
- Correct EXPOSE and CMD

**docker-compose.yml**
Full stack: agent + Redis (for rate limiting/caching) + optional PostgreSQL.

**Deployment Instructions**
Platform-specific commands from Mode 2 of `agent-deployment`.
For Railway / Render: complete CLI commands.
For VPS: full server setup including nginx and SSL.

**Security Checklist**
- Environment variables for all secrets
- CORS configured to specific origins
- Rate limiting per IP (using Mode 3 of `agent-deployment`)
- Hard spend cap on LLM API keys — include the provider's console link
- HTTPS only (HTTP → HTTPS redirect)

**Cost Monitoring**
Complete logging setup from Mode 4 of `agent-deployment`:
- Structured logs (JSON) with token count + cost per request
- Slack alert when daily cost exceeds threshold
- Prometheus metrics endpoint

**Health Check**
`GET /health` endpoint that returns status + timestamp.
Configure uptime monitoring (UptimeRobot free tier — monitors every 5 min).

**CI/CD Pipeline**
GitHub Actions workflow from Mode 5 of `agent-deployment`:
- Test → Build → Deploy on push to main
- Slack notification on deploy success/failure

**Environment Variables**
Complete `.env.example` — every variable the app needs, with no values.
