---
name: new-project
description: Load when starting any new project from scratch. Covers stack selection, repo init, env setup, CI/CD, and first-deploy checklist for Virgi's typical projects.
---

# New Project Kickstart

## Step 1 — Tentukan Stack

### Web App (SPA)
```
React + Vite + TypeScript → Vercel
Supabase (Auth + DB) kalau butuh backend
Tailwind CSS untuk styling
```

### Web App (Full-stack / SSR)
```
Next.js + TypeScript → Vercel
Supabase atau Prisma + Postgres (Railway/Neon)
```

### Mobile App
```
React Native + Expo → EAS Build
Supabase untuk backend (sama dengan web)
Expo Router untuk navigation
```

### API Only / Backend
```
Node.js + Fastify/Express + TypeScript → Railway/Fly.io
Postgres via Supabase atau Railway
```

### Landing Page / Static
```
Astro atau Next.js static → Vercel / Cloudflare Pages
```

## Step 2 — Init Repo

```bash
# Web SPA
npm create vite@latest nama-project -- --template react-ts
cd nama-project
npm install

# Next.js
npx create-next-app@latest nama-project --typescript --tailwind --app

# Mobile
npx create-expo-app@latest nama-project --template blank-typescript

# Git
git init
git add .
git commit -m "feat: initial project setup"
gh repo create virgiangalang/nama-project --private --source=. --push
```

## Step 3 — Setup Env

```bash
# Buat .env.local (untuk local dev)
# Buat .env.example (commit ke repo — tanpa nilai sensitif)
echo ".env.local" >> .gitignore
echo ".env" >> .gitignore
```

`.env.example`:
```
# Supabase
VITE_SUPABASE_URL=
VITE_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# App
VITE_APP_URL=http://localhost:5173
APP_URL=http://localhost:5173
```

## Step 4 — Setup Supabase (kalau butuh backend)

```bash
# Install
npm install @supabase/supabase-js

# Buat project di supabase.com
# Copy URL + anon key ke .env.local
# Enable Email/Google Auth di Dashboard
# Setup RLS dari awal
```

## Step 5 — Setup Vercel (untuk deploy)

```bash
npm install -g vercel
vercel login
vercel link          # link ke project Vercel
vercel env pull      # pull env dari Vercel ke .env.local
```

`vercel.json` minimal:
```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "vite"
}
```

## Step 6 — Struktur Folder (Web SPA)

```
src/
├── api/              # Vercel serverless functions (kalau ada)
├── components/       # Reusable UI components
│   └── ui/           # Primitives (Button, Input, Modal)
├── hooks/            # Custom React hooks
├── lib/              # Utils, API clients, constants
├── pages/ (atau app/) # Route-level components
├── store/            # Global state (Zustand)
├── types/            # TypeScript interfaces
└── main.tsx
public/
.env.local            # Secret (gitignored)
.env.example          # Template (committed)
vercel.json
```

## Step 7 — CLAUDE.md per Project

Buat `CLAUDE.md` di root project berisi:
```markdown
# [Nama Project]

## Stack
...

## Absolute Constraints
...

## Architecture
...
```

Ini yang bikin semua AI agent (Claude, Cursor, Codex) langsung paham konteks project.

## Step 8 — First Deploy Checklist

- [ ] Env vars sudah di Vercel dashboard (bukan di-commit)
- [ ] `.env.local` ada di `.gitignore`
- [ ] RLS enabled di semua Supabase table
- [ ] `npm run build` sukses tanpa error lokal
- [ ] Domain custom sudah di-set (kalau ada)
- [ ] `git push origin main` → Vercel auto-deploy

## Naming Conventions (Virgi's Standard)

```
Project folder:   nama-project (kebab-case)
GitHub repo:      virgiangalang/nama-project
Vercel project:   nama-project
Supabase project: nama-project
Domain:           namaproject.id atau namaproduct.id (avoid "tarot", "ai" di domain)
```

## Git Commit Convention
```
feat(scope): tambah fitur X
fix(scope): perbaiki bug Y
docs: update README
refactor(scope): refactor Z tanpa behavior change
chore: update dependencies
```

## Common First Dependencies

```bash
# State
npm install zustand

# Forms
npm install react-hook-form zod @hookform/resolvers

# Date
npm install date-fns

# Icons
npm install lucide-react

# Tailwind (kalau belum)
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```
