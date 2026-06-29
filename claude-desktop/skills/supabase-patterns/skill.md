---
name: supabase-patterns
description: Load when working with Supabase — RLS policies, RPC functions, auth, realtime, edge functions, and common patterns for Postgres + Supabase projects.
---

# Supabase Patterns

## RLS (Row Level Security)

Always enable RLS on every table. Never turn it off.

```sql
-- Pattern dasar: user hanya bisa akses data sendiri
CREATE POLICY "Users can only see own data"
  ON table_name
  FOR ALL
  USING (auth.uid() = user_id);

-- Pattern untuk insert
CREATE POLICY "Users can insert own data"
  ON table_name
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Pattern untuk service role bypass (pakai di server-side saja)
-- Di client: ANON key → kena RLS
-- Di server: SERVICE_ROLE key → bypass RLS (gunakan dengan hati-hati)
```

## Auth Patterns

```typescript
// Server-side: gunakan service role untuk admin operations
import { createClient } from '@supabase/supabase-js'
const supabaseAdmin = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
)

// Client-side: anon key + RLS
const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY
)

// Get current user server-side dari JWT
const { data: { user } } = await supabaseAdmin.auth.getUser(accessToken)
```

## RPC Functions

Gunakan RPC untuk logic yang butuh atomicity atau perlu bypass RLS dengan aman.

```sql
-- Buat function dengan SECURITY DEFINER untuk bypass RLS
CREATE OR REPLACE FUNCTION get_user_stats(p_user_id UUID)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER  -- jalankan sebagai owner function, bukan caller
AS $$
BEGIN
  -- Logic di sini aman dari RLS
  RETURN (SELECT row_to_json(t) FROM (...) t);
END;
$$;

-- Revoke public access, grant ke authenticated saja
REVOKE ALL ON FUNCTION get_user_stats FROM PUBLIC;
GRANT EXECUTE ON FUNCTION get_user_stats TO authenticated;
```

```typescript
// Call RPC dari client
const { data, error } = await supabase.rpc('get_user_stats', {
  p_user_id: userId
})
```

## Common Gotchas

- **Jangan insert dengan `user_id: undefined`** — RLS akan block. Pastikan user sudah login.
- **Service role key = full access** — jangan pernah expose ke frontend atau commit ke repo.
- **`auth.uid()`** hanya tersedia di SQL saat request ada JWT valid. Di seed/migration, gunakan hardcoded UUID.
- **Realtime** perlu RLS policy yang include `SELECT` — tanpa ini realtime tidak akan kirim event.
- **Storage bucket** punya RLS sendiri terpisah dari table.

## Migrations

```sql
-- Selalu gunakan IF NOT EXISTS / OR REPLACE
-- Jangan drop table di production migration kecuali ada backup

-- Pattern add column safely
ALTER TABLE users ADD COLUMN IF NOT EXISTS credits INTEGER DEFAULT 0;

-- Pattern index
CREATE INDEX IF NOT EXISTS idx_readings_user_id ON readings(user_id);
CREATE INDEX IF NOT EXISTS idx_readings_created_at ON readings(created_at DESC);
```

## Edge Functions vs API Routes

- **Supabase Edge Functions**: cocok untuk webhook handler, cron jobs, logic yang perlu dekat database
- **Vercel API Routes** (untuk stack Vercel): cocok untuk semua endpoint user-facing
- Jangan mix dua-duanya tanpa alasan kuat — pilih satu sebagai primary

## Useful Queries

```sql
-- Check semua policy di table
SELECT * FROM pg_policies WHERE tablename = 'your_table';

-- Check RLS enabled/disabled
SELECT tablename, rowsecurity FROM pg_tables WHERE schemaname = 'public';

-- Explain query performance
EXPLAIN ANALYZE SELECT * FROM readings WHERE user_id = '...';
```
