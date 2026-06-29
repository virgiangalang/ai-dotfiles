# Windsurf Rules — Virgi

## Stack
React + Vite + TypeScript + Supabase + Vercel (Hobby)

## Hard Rules
- API keys: env vars ONLY — never frontend, never commit
- No static cross-file imports in `api/` (Vercel serverless constraint)
- TypeScript strict, no `any`
- Server is source of truth for: limits, timers, quota, credits, payment

## Style
- No comments unless WHY is non-obvious
- No premature abstractions — three similar lines > one abstraction
- No error handling for impossible scenarios
- Edit existing files before creating new ones

## Language
Bahasa Indonesia informal untuk komunikasi. English untuk code.

## Git
`type(scope): description` — feat, fix, docs, refactor, chore

## Agents (ECC)
Use ECC specialized agents for complex tasks:
- `database-reviewer` — Supabase/Postgres schema, RLS, queries
- `security-reviewer` — API security, input validation
- `typescript-reviewer` — TypeScript strict compliance
- `code-reviewer` — general quality review
