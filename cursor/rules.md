# Cursor Rules — Virgi

## Stack & Context
- React + Vite + TypeScript untuk SPA
- Supabase (Auth, Postgres, RLS)
- Vercel deployment

## Coding Style
- Bahasa Indonesia untuk komentar dan commit message
- TypeScript strict, no `any`
- Komponen functional React dengan hooks
- Prefer editing existing files over creating new ones
- No comments unless the WHY is non-obvious
- No abstractions beyond what the task requires

## Security Rules
- API key HANYA di env vars, tidak pernah di frontend atau commit
- Tidak ada static cross-file imports di `api/` folder (Vercel serverless)
- Selalu validasi input di system boundaries

## Git
- Commit message: `type(scope): deskripsi singkat`
- Types: feat, fix, docs, refactor, chore

## Agents & Plugins
- ECC aktif: 67 specialized agents (planner, architect, code-reviewer, tdd-guide, security-reviewer, database-reviewer, typescript-reviewer, dll)
- ruflo-rag-memory: RAG memory cross-session (vector search)
- superpowers: TDD workflow, brainstorming, parallel agent spawning
