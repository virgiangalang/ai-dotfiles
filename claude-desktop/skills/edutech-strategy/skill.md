---
name: edutech-strategy
description: Edtech product strategy, curriculum design, LMS selection, learning outcomes, and go-to-market for Indonesia and Southeast Asia. Pairs with market-research (ECC) for segment validation, data-analytics for cohort retention and completion tracking, and business-model-canvas for revenue model design. Includes Bloom's Taxonomy, backward design, engagement framework, and quality gate.
---

# Edtech Strategy

## Skill Stack

- `market-research` (ECC) — validate target learner segment, willingness to pay, and competitor landscape before designing curriculum
- `data-analytics` — track cohort retention, completion rates, assessment pass rates, and NPS trends
- `business-model-canvas` — design and stress-test the edtech revenue model (subscription, B2B, bootcamp, marketplace)
- `product-strategy` — roadmap and PMF validation for edtech products; run `product-lens` before speccing features
- `stakeholder-comms` — when communicating to institutional buyers (schools, HR directors, government)
- `marketing-campaign` (ECC) — go-to-market campaigns for B2C learner acquisition

## Guardrails

- Do not design curriculum without first defining learning outcomes using Bloom's Taxonomy — "learning to learn" is not an outcome
- Buyer ≠ User in edtech: always map the purchase decision (institution, parent, employer) separately from the user experience (student, employee) — designing for the wrong person kills both
- Completion rate benchmarks: <30% is a red flag for async courses, >60% requires active intervention design — know your baseline before claiming success
- Never position an edtech product around "access to content" as the primary value — content is commodity; outcomes, accountability, and community are the moat
- Indonesia-specific: mobile-first is non-negotiable (>80% of learners use phones), Bahasa Indonesia content is a significant competitive moat vs. global players
- Kartu Prakerja is the single highest-leverage distribution channel for consumer upskilling in Indonesia — if this applies to your product, understand the approval process before anything else

## Quality Gate

Before shipping an edtech feature or go-to-market plan:
- [ ] Learning outcomes written using Bloom's Taxonomy action verbs (not "students will understand X")
- [ ] Curriculum designed backward from outcomes (Step 1: outcomes → Step 2: evidence → Step 3: activities)
- [ ] Engagement interventions mapped to each dropout-risk moment (Day 1, Week 1, completion)
- [ ] Key metrics defined: completion rate, D7 retention, NPS, outcome achievement
- [ ] Revenue model validated against unit economics (CAC, LTV, payback period)
- [ ] Mobile experience verified (if Indonesia market)

## The Edtech Market Reality

Edtech is different from other software:
- **Buyer ≠ User** (institution buys, students use — or parents buy, kids use)
- **Outcomes are slow to materialize** (learning takes time to prove)
- **Motivation is the core problem** (people want to learn, not to study)
- **Trust is the moat** (reputation, curriculum quality, outcomes data)

---

## Learning Design Fundamentals

### Bloom's Taxonomy (What Level Are You Teaching To?)

```
Level 6: Create   → Student can produce something new
Level 5: Evaluate → Student can judge, critique, defend
Level 4: Analyze  → Student can break down, compare, contrast
Level 3: Apply    → Student can use knowledge in new situations
Level 2: Understand → Student can explain in their own words
Level 1: Remember  → Student can recall facts
```

Most courses stop at Level 2. Great ones reach 4–6.

### Learning Outcomes Formula

```
By the end of [course/module/lesson], students will be able to:
[ACTION VERB from Bloom's] + [CONTENT] + [CONTEXT/STANDARD]

Example:
"By the end of this module, students will be able to design
a RESTful API that handles authentication and rate limiting."
```

---

## Curriculum Design Framework

### Backward Design (Wiggins & McTighe)

```
Step 1: Define the desired outcomes (what should students be able to DO?)
Step 2: Determine acceptable evidence (how will you know they can do it?)
Step 3: Plan learning experiences (what activities lead there?)
```

Most people start at Step 3. That's why most curricula don't lead to real outcomes.

### Course Structure Template

```
Course: [Name]
Target learner: [Who exactly] at [what level]
Time commitment: [Total hours] over [weeks]
Format: [Async video / live / blended / cohort-based]

Module 1: [Name]
├── Lesson 1.1: [Topic] — [format] — [duration]
├── Lesson 1.2: [Topic] — [format] — [duration]
├── Practice: [exercise or project]
└── Assessment: [quiz / project / peer review]

[Repeat for each module]

Capstone: [Final project that demonstrates all outcomes]
```

---

## LMS Selection (Learning Management System)

| Criteria | Weight | Questions to Ask |
|----------|--------|-----------------|
| Ease of use | High | Can a non-technical instructor use it? |
| Learner experience | High | Mobile-friendly? Intuitive navigation? |
| Assessment tools | High | Quiz types, auto-grading, rubrics? |
| Analytics | Medium | Can you track completion, engagement, outcomes? |
| Integration | Medium | Connect to CRM, payment, video, Zoom? |
| Pricing model | Medium | Per-user, per-course, flat fee? |
| Support | Medium | Response time, documentation quality |
| Scalability | Low-High | 100 students vs. 100,000 students |

**Popular options by context:**

| Context | Options |
|---------|---------|
| Corporate training | Docebo, TalentLMS, Cornerstone |
| Online course creators | Teachable, Thinkific, Kajabi |
| Higher education | Canvas, Moodle, Blackboard |
| Enterprise (self-hosted) | Moodle, Open edX |
| Indonesia market | Sekolah.mu, Pijar Mahir (local), Zoom + Google Classroom |

---

## Student Engagement Framework

### The Engagement Stack

```
Motivation (Why care?) 
  → Activation (First experience is great)
    → Habit (Make it easy to return)
      → Achievement (Progress feels real)
        → Community (Don't learn alone)
```

### Engagement Tactics

| Stage | Tactic |
|-------|--------|
| Pre-enroll | Clear outcomes, social proof, sample lesson |
| Day 1 | Quick win within first 10 minutes, welcome message |
| Week 1 | Progress bar, streak, first badge, cohort intro |
| Ongoing | Spaced repetition, peer projects, live sessions |
| At-risk | Proactive outreach when engagement drops |
| Completion | Certificate, showcase, alumni community |

### Key Metrics

| Metric | What It Tells You |
|--------|-----------------|
| Enrollment → Start rate | Is the welcome flow working? |
| Start → Day 7 retention | Is the early experience compelling? |
| Completion rate | Is the course the right length and difficulty? |
| Assessment pass rate | Is the curriculum effective? |
| NPS / satisfaction score | Would learners recommend it? |
| Time-to-completion | Are learners progressing at expected pace? |
| Outcome achievement | Are learners actually getting the job / skill? |

---

## Edtech Go-to-Market

### B2C (Direct to Learner)
- Content marketing (YouTube, TikTok, Instagram showing expertise)
- Community building (Discord, Facebook Groups, Telegram)
- Influencer partnerships (micro-influencers in niche)
- Freemium or free first lesson to reduce friction

### B2B (Institutions, Companies)
- Target: HR Directors, Learning & Development, School Principals
- ROI calculator: cost of training vs. cost of hiring/turnover
- Pilot program → case study → expansion
- Government partnership (especially Indonesia: Kartu Prakerja, Kemendikbud)

### Indonesia-Specific
- Kartu Prakerja: government-subsidized upskilling — major distribution channel
- Partnership with Tokopedia, Skill Academy, Coursera Indonesia
- Bahasa Indonesia content is a significant moat vs. global players
- Mobile-first: most learners access via phone, not desktop

---

## Edtech Business Models

| Model | How It Works | Best For |
|-------|-------------|---------|
| Course marketplace | Revenue share with instructors | Udemy-style, scale content |
| Subscription | Flat fee, access to all content | Netflix-style, retention focus |
| Cohort-based | Fixed cohort, live sessions, premium price | Community, accountability |
| B2B license | Sell to company or institution per-seat | Enterprise LMS |
| Bootcamp | Intensive, outcome-guaranteed, high price | Career changers |
| Income share | No upfront cost, % of salary after job | Risk-aligned, bootcamp |
