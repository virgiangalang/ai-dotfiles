---
name: vercel-serverless
description: Load when writing Vercel API routes / serverless functions. Critical constraints for api/ folder that prevent all-endpoint failures on deploy.
---

# Vercel Serverless Patterns

## CONSTRAINT MUTLAK — Ini Pernah Membunuh Semua Endpoint

**NO static cross-file imports di `api/` folder.**

```typescript
// ❌ SALAH — ini break semua endpoint di Vercel production
import { createClient } from '../src/lib/supabase'
import { PRICING_TIERS } from '../src/constants/pricing'
import type { ReadingResult } from '../src/types'

// ✅ BENAR — semua logic inline atau import dari npm packages saja
import { createClient } from '@supabase/supabase-js'  // npm package = OK
import { GoogleGenerativeAI } from '@google/generative-ai'  // npm package = OK

// Logic yang dipakai banyak endpoint → copy-paste inline per file
// (tidak ideal tapi ini satu-satunya safe pattern di Vercel)
```

## File Structure

```
api/
├── reading.ts          # Standalone, semua logic inline
├── followup.ts         # Standalone
├── payment/
│   ├── create.ts       # Pricing logic inline di sini, bukan import
│   └── webhook.ts      # Webhook handler standalone
└── cron/
    └── followup.ts     # Cron job standalone
```

## Handler Pattern (TypeScript)

```typescript
import type { VercelRequest, VercelResponse } from '@vercel/node'

export default async function handler(req: VercelRequest, res: VercelResponse) {
  // CORS — kalau dibutuhkan
  res.setHeader('Access-Control-Allow-Origin', process.env.APP_URL || '*')
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')

  if (req.method === 'OPTIONS') return res.status(200).end()
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' })

  try {
    // Logic di sini
    return res.status(200).json({ success: true, data: result })
  } catch (err) {
    console.error('Handler error:', err)
    return res.status(500).json({ error: 'Internal server error' })
  }
}
```

## Env Vars

```typescript
// Server-side: process.env (tanpa VITE_ prefix)
const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

// Client-side: import.meta.env.VITE_* (hanya yang VITE_ prefix)
// JANGAN akses process.env dari frontend — tidak akan ada nilainya
```

## Auth di API Routes

```typescript
// Extract user dari Authorization header
const authHeader = req.headers.authorization
const token = authHeader?.replace('Bearer ', '')

if (!token) return res.status(401).json({ error: 'Unauthorized' })

const { data: { user }, error } = await supabaseAdmin.auth.getUser(token)
if (error || !user) return res.status(401).json({ error: 'Invalid token' })
```

## Rate Limiting Pattern

```typescript
// Cek limit di database, bukan di memory (serverless = stateless)
const { data: todayCount } = await supabase
  .from('readings')
  .select('id', { count: 'exact' })
  .eq('user_id', user.id)
  .gte('created_at', new Date().toISOString().split('T')[0])

if ((todayCount?.length ?? 0) >= DAILY_LIMIT) {
  return res.status(429).json({ error: 'Daily limit reached' })
}
```

## Cron Jobs (`vercel.json`)

```json
{
  "crons": [
    {
      "path": "/api/cron/followup",
      "schedule": "0 10 * * *"
    }
  ]
}
```

```typescript
// Protect cron endpoint
if (req.headers.authorization !== `Bearer ${process.env.CRON_SECRET}`) {
  return res.status(401).json({ error: 'Unauthorized' })
}
```

## Vercel Limits (Hobby Plan)
- Function timeout: 10 detik (60 detik untuk Pro)
- Memory: 1024 MB
- Cold start: ~500ms (minify dan tree-shake kalau lambat)
- Deploy: otomatis via `git push origin main`

## vercel.json Boilerplate

```json
{
  "headers": [
    {
      "source": "/api/(.*)",
      "headers": [
        { "key": "Cache-Control", "value": "no-store" }
      ]
    }
  ]
}
```
