---
name: payment-gateway-id
description: Load when integrating Indonesian payment gateways — Midtrans, Xendit, Doku, iPaymu. Includes webhook patterns, sandbox testing, and approval requirements.
---

# Payment Gateway Indonesia

## Perbandingan Gateway

| Gateway | Status Virgi | Sandbox | MDR Kartu | Transfer Bank | Approval |
|---------|-------------|---------|-----------|---------------|---------|
| Midtrans | Rejected, reapply dengan NIB+NPWP | ✅ | ~2% | Free | PT/CV + NIB |
| Xendit | Hampir approved | ✅ | ~2.4% | Rp 5.500 | NIB + domain |
| Doku (Jokul) | Submitted, ditinjau | ✅ | ~2% | Free | NIB + PT |
| iPaymu | Belum submit | ✅ | ~2% | Free | IG/sosmed + refund policy |

## Midtrans Snap

### Setup

```typescript
// Server: buat transaction token
const response = await fetch(
  `https://app.sandbox.midtrans.com/snap/v1/transactions`,
  {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Basic ${Buffer.from(process.env.MIDTRANS_SERVER_KEY + ':').toString('base64')}`
    },
    body: JSON.stringify({
      transaction_details: {
        order_id: `ORDER-${Date.now()}`,
        gross_amount: 20000
      },
      customer_details: {
        email: user.email
      },
      callbacks: {
        finish: `${process.env.APP_URL}/payment/success`
      }
    })
  }
)
const { token } = await response.json()
```

```typescript
// Client: tampilkan Snap popup
declare const snap: any  // loaded via CDN script tag

snap.pay(snapToken, {
  onSuccess: (result) => { /* update UI, refresh credits */ },
  onPending: (result) => { /* tampilkan pending message */ },
  onError: (result) => { /* handle error */ },
  onClose: () => { /* user tutup popup */ }
})
```

```html
<!-- Load Snap script — production vs sandbox via env -->
<script src="https://app.sandbox.midtrans.com/snap/snap.js"
  data-client-key="${VITE_MIDTRANS_CLIENT_KEY}"></script>
```

### Webhook Handler

```typescript
// Verifikasi signature Midtrans
import crypto from 'crypto'

function verifyMidtransSignature(orderId: string, statusCode: string, grossAmount: string, serverKey: string, signatureKey: string): boolean {
  const hash = crypto
    .createHash('sha512')
    .update(orderId + statusCode + grossAmount + serverKey)
    .digest('hex')
  return hash === signatureKey
}

// Di webhook handler
const { order_id, status_code, gross_amount, signature_key, transaction_status } = req.body

const valid = verifyMidtransSignature(order_id, status_code, gross_amount, process.env.MIDTRANS_SERVER_KEY!, signature_key)
if (!valid) return res.status(400).json({ error: 'Invalid signature' })

if (transaction_status === 'settlement' || transaction_status === 'capture') {
  // Grant credits ke user
}
```

### Switch Sandbox → Production
1. Ganti env: `MIDTRANS_ENV=production`
2. Ganti `MIDTRANS_SERVER_KEY` dan `MIDTRANS_CLIENT_KEY` ke production keys
3. Ganti Snap URL: `app.sandbox.midtrans.com` → `app.midtrans.com`
4. Test dengan kartu production sebelum go-live

## Xendit

```typescript
// Create invoice
const response = await fetch('https://api.xendit.co/v2/invoices', {
  method: 'POST',
  headers: {
    'Authorization': `Basic ${Buffer.from(process.env.XENDIT_SECRET_KEY + ':').toString('base64')}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    external_id: `INV-${Date.now()}`,
    amount: 20000,
    payer_email: user.email,
    description: 'Lunara Reading Credits',
    success_redirect_url: `${process.env.APP_URL}/payment/success`,
    currency: 'IDR'
  })
})
const invoice = await response.json()
// redirect user ke invoice.invoice_url
```

## Doku (Jokul)

```typescript
// Doku pakai HMAC-SHA256 signature
const requestId = Date.now().toString()
const signature = crypto
  .createHmac('sha256', process.env.DOKU_SECRET_KEY!)
  .update(`${process.env.DOKU_CLIENT_ID}|${requestId}|${requestTarget}|${JSON.stringify(body)}`)
  .digest('base64')
```

## Universal Webhook Pattern

```typescript
// Selalu:
// 1. Verifikasi signature
// 2. Check idempotency (order sudah diproses?)
// 3. Update database
// 4. Return 200 cepat (gateway retry kalau tidak dapat 200)

const existing = await supabase
  .from('payments')
  .select('id')
  .eq('order_id', orderId)
  .eq('status', 'success')
  .single()

if (existing.data) {
  return res.status(200).json({ message: 'Already processed' })  // idempotent
}

// Process dan update
await supabase.from('payments').upsert({ order_id: orderId, status: 'success', ... })
```

## Dokumen yang Dibutuhkan untuk Approval
- SK Kemenkumham (AHU) atau NIB OSS
- NPWP Badan / Pribadi
- Domain aktif dengan SSL (lunaraspace.id)
- Privacy Policy, Terms of Service, Refund Policy (halaman dedicated URL)
- KTP Direktur
- Rekening bank atas nama PT

## Test Cards (Midtrans Sandbox)
- **Success:** 4811 1111 1111 1114, CVV: 123, Exp: 01/25
- **Failure:** 4911 1111 1111 1113
- **OTP:** 112233
