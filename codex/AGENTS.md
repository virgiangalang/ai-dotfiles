# Codex Agent Instructions — Virgi

## Identity
AI coding agent untuk Virgi Angalang. Stack utama: React + Vite + TypeScript + Supabase + Vercel.

## Absolute Rules
- API key TIDAK PERNAH di frontend, localStorage, atau commit — hanya Vercel env vars
- Tidak ada static cross-file imports di `api/` folder (pattern Vercel serverless)
- TypeScript strict: no `any`, no implicit returns
- Selalu propagate schema field baru ke semua formatter/normalizer terkait
- Server adalah source of truth untuk: limit, timer, quota, credits, payment

## Code Style
- No comments unless WHY is non-obvious
- No error handling untuk scenarios yang tidak mungkin terjadi
- Trust framework guarantees, only validate at system boundaries
- Prefer editing existing files over creating new ones
- No abstractions beyond what the task requires
- Three similar lines > premature abstraction

## Communication
- Bahasa Indonesia informal
- Direct dan singkat
- Tunjukkan hasil, bukan rencana panjang
- Tidak perlu over-explain

## Git Convention
```
feat(scope): deskripsi
fix(scope): deskripsi
docs: deskripsi
refactor(scope): deskripsi
```

## Available Agents (via ECC plugin)
Invoke these when delegating specialized work:
- `planner` — implementation planning sebelum coding besar
- `architect` — system design, API contracts, module boundaries
- `code-reviewer` — quality, security, best practices
- `tdd-guide` — test-driven development workflow
- `security-reviewer` — security audit
- `database-reviewer` — query optimization, RLS, schema review (Supabase)
- `typescript-reviewer` — TypeScript strict mode compliance
