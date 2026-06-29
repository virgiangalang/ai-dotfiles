---
name: email-marketing
description: Email marketing strategy — sequence design, campaign planning, deliverability optimization, and A/B testing. Covers welcome sequences, nurture flows, re-engagement, and promotional emails. Pairs with copywriting for email copy, growth-metrics for email KPIs, and marketing-strategy for email's role in the channel mix. For email marketers, CMOs, and founders running retention and acquisition via email.
---

# Email Marketing

## Skill Stack

- `copywriting` — email copy frameworks (AIDA, PAS, subject lines); write the brief before the email
- `growth-metrics` — email KPIs (open rate, CTR, conversion, unsubscribe, revenue per email)
- `marketing-strategy` — email is a MOFU/BOFU channel; position it correctly in the funnel
- `data-analytics` — segment performance analysis, A/B test significance, cohort email behavior
- `brand-strategy` — email is a high-frequency brand touchpoint; voice and tone must be consistent

## Guardrails

- Subject lines are 50% of email performance — write 5 before picking 1; test them
- Never email your list without a reason — every email needs a stated value to the reader; "monthly newsletter" is not a reason
- Deliverability is infrastructure, not afterthought — a list of 10,000 with 30% open rate is more valuable than 100,000 with 8%
- One email, one goal — sending an email with 3 CTAs is sending an email with no CTA
- List hygiene is not optional — email addresses that bounce or never engage hurt your sender reputation and everyone else's deliverability on your domain

## Email KPI Benchmarks

| Metric | Good | Needs Work | Formula |
|--------|------|-----------|---------|
| Open Rate | >30% (B2B) / >20% (B2C) | <15% | Opens / Sent |
| Click Rate (CTR) | >3% | <1% | Clicks / Sent |
| Click-to-Open Rate | >15% | <10% | Clicks / Opens |
| Conversion Rate | >2% | <0.5% | Goal completions / Clicks |
| Unsubscribe Rate | <0.3% | >0.5% | Unsubs / Sent |
| Bounce Rate (hard) | <0.5% | >2% | Hard bounces / Sent |
| Spam Rate | <0.08% | >0.1% | Spam reports / Sent |
| Revenue per Email | Track vs. baseline | — | Revenue / Emails sent |

## Mode 1: Welcome Sequence

**Goal:** Convert a new subscriber into an engaged reader and potential customer.  
**Timing:** Automated; start immediately; spread over 5–7 days.

```
EMAIL 1 (Immediately): The Warm Welcome
Subject: "You're in — here's what to expect"
Goal: Set expectations, deliver the promised lead magnet, introduce yourself

Body structure:
- Deliver the promised resource (lead magnet, guide, discount code)
- 1-2 sentences about who you are and why you exist
- What they'll get from this list (topics, frequency)
- One soft CTA: read your most popular article / follow on [platform]

EMAIL 2 (Day 2): The Most Valuable Thing
Subject: "[Your best piece of content / insight]"
Goal: Deliver immediate value; prove you're worth reading

Body: Your single best insight, framework, or resource. No selling.

EMAIL 3 (Day 4): The Story
Subject: "Why I started [Brand]" or "The mistake that changed everything"
Goal: Build trust through transparency and founder story

Body: The real story — why the company exists, who it's for, what you believe.

EMAIL 4 (Day 7): The Transition to Solution
Subject: "The #1 thing [ICP] struggle with (and what actually works)"
Goal: Bridge from content to product; soft introduce the product

Body:
- Name the core pain your ICP has
- Why most solutions fail
- Introduce your approach
- Soft CTA: "We built [Product] to solve this. [Learn more / See how]"

EMAIL 5 (Day 10): Social Proof
Subject: "How [Customer] achieved [result]"
Goal: Case study / testimonial to build conviction

Body: Customer story (Before → After → Result). Include a quote.
CTA: "Want results like [Customer]? [Start free trial / Book demo]"
```

## Mode 2: Nurture Sequence (MOFU)

**Goal:** Move engaged leads from awareness to consideration over 3–6 weeks.

```
Sequence design principles:
- Frequency: 1–2 emails per week (more = unsubscribes; less = forgotten)
- Mix: 70% value (education, insights, case studies) / 30% offers
- Segmentation: trigger different sequences based on behavior (lead magnet topic, page visited)

Nurture email types (rotate):
  Education: "The [framework/guide] for [solving their problem]"
  Social proof: "How [customer] solved [specific version of their problem]"
  Insight: "The counterintuitive truth about [topic]"
  FAQ: "The question we get most often (and our honest answer)"
  Comparison: "[Your approach] vs. [alternatives] — the real difference"
  Offer: "When you're ready: [CTA]"
```

## Mode 3: Re-Engagement Sequence

**Goal:** Win back subscribers who haven't opened in 90+ days.  
**Trigger:** No open/click in 90 days.

```
EMAIL 1 — Pattern interrupt
Subject: "We miss you. Do you still want to hear from us?"
Body: Direct and honest. "You signed up X months ago and haven't opened recently.
We don't want to send you emails you don't want. Still interested? [Yes, keep me subscribed]
If not, we'll remove you in 3 days."

EMAIL 2 (3 days later) — Last chance
Subject: "Last email before we remove you"
Body: Final reminder. Include your strongest offer or piece of content.
[Stay subscribed] | [Unsubscribe now]

Action after sequence:
- Didn't re-engage: remove from active list (do not delete — suppress for deliverability)
- Re-engaged: add to active nurture sequence
```

## Mode 4: Deliverability Optimization

Deliverability determines whether your emails reach the inbox or spam folder.

```
TECHNICAL SETUP (one-time, critical)
  [ ] SPF record configured (your sending IP authorized)
  [ ] DKIM configured (cryptographic signature on emails)
  [ ] DMARC policy configured (what to do with failed auth)
  [ ] Custom sending domain (not shared IP from ESP)
  [ ] Verified email domain (not Gmail/Yahoo sender)

LIST HEALTH (ongoing)
  [ ] Remove hard bounces immediately after each send
  [ ] Suppress subscribers who haven't opened in 6+ months (run re-engagement first)
  [ ] Use double opt-in for new subscribers (higher quality list)
  [ ] Never purchase or rent email lists (destroys sender reputation)

SENDING BEHAVIOR
  [ ] Warm up new domains gradually (start: 50/day → 500/day → 5000/day over 6 weeks)
  [ ] Maintain consistent send frequency (irregular spikes trigger filters)
  [ ] Avoid spam trigger words in subject lines: Free, Act Now, Limited time, !!!, ALL CAPS
  [ ] Include physical address and unsubscribe link in every email (CAN-SPAM / GDPR)

ENGAGEMENT SIGNALS (Google / ISPs watch these)
  [ ] Segment and suppress low-engagement subscribers before large sends
  [ ] Send from a person (name@company.com) not a role (noreply@company.com)
  [ ] Reply-to is a monitored inbox (replies improve sender reputation)
```

## Mode 5: A/B Testing

**What to test and in what order:**

| Priority | Element | Test Options |
|----------|---------|-------------|
| 1 | Subject line | Short vs. long, question vs. statement, with/without emoji |
| 2 | Send time | Morning vs. afternoon, weekday vs. weekend |
| 3 | From name | First name vs. full name vs. brand name |
| 4 | CTA button | Text A vs. text B, color A vs. color B |
| 5 | Email length | Short and direct vs. longer story-driven |
| 6 | Preheader text | Descriptive vs. curiosity-gap vs. matches subject |

**A/B Test Rules:**
- Test ONE variable at a time — testing two changes at once means you can't attribute the winner
- Minimum sample size: 200 per variant to reach statistical significance
- Run for at least 4 hours (subject line test) to 48 hours (full campaign) before declaring a winner
- Apply winning variant to future sends; build your own playbook from results

## Quality Gate

Before launching an email program:
- [ ] SPF, DKIM, DMARC configured on sending domain
- [ ] Welcome sequence automated (minimum 3 emails)
- [ ] Unsubscribe link in every email (legal requirement)
- [ ] Physical address in every email (CAN-SPAM / GDPR)
- [ ] Double opt-in or clear consent mechanism in place
- [ ] List segmentation defined (by lifecycle stage minimum)
- [ ] Success metrics defined: open rate, CTR, conversion rate, revenue per email
- [ ] A/B test running on subject lines for every major send
- [ ] Re-engagement sequence automated (90-day trigger)
