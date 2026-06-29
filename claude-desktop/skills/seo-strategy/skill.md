---
name: seo-strategy
description: SEO strategy covering keyword research, on-page optimization, technical SEO audit, content SEO, and link building. Pairs with content-strategy for SEO content planning, data-analytics for ranking and traffic analysis, and marketing-strategy for organic channel investment. For SEO specialists, content leads, and CMOs building compounding organic growth.
---

# SEO Strategy

## Skill Stack

- `content-strategy` — SEO is content's distribution mechanism; keyword research drives the content calendar
- `data-analytics` — traffic trends, ranking position analysis, CTR optimization from GSC/GA4 data
- `marketing-strategy` — SEO is a long-term channel; set expectations on timeline before budgeting
- `copywriting` — on-page copy optimization; meta descriptions, title tags, and H1 formulas

## Guardrails

- SEO is a 6–12 month investment minimum — never promise quick wins to stakeholders; set timeline expectations upfront
- Keyword research must include search intent classification — writing the wrong content type for a keyword wastes budget
- Technical SEO issues block all content efforts — audit technical health before creating more content
- Backlinks cannot be bought or manipulated (black-hat tactics cause Google penalties) — earn them through linkable assets
- Domain Authority is a Moz metric, not a Google metric — do not make decisions based on DA alone; use real ranking data

## Mode 1: Keyword Research

**Keyword Research Process:**
```
Step 1: Seed keyword discovery
  - List 10–20 topics your ICP cares about
  - Add competitors' top-ranking pages
  - Check "People Also Ask" and "Related Searches" in Google

Step 2: Keyword tool expansion
  - Google Search Console (what you already rank for)
  - Google Keyword Planner (volume estimates)
  - Ahrefs / SEMrush / Ubersuggest (competitor gap analysis)

Step 3: Filter by intent + opportunity
  - Intent: Informational → TOFU | Commercial → MOFU | Transactional → BOFU
  - Opportunity: High volume + low competition = best early targets
  - Remove: irrelevant, no commercial value, impossible KD (keyword difficulty >80 for new site)

Step 4: Cluster keywords
  - Group by topic (not exact match) — one cluster = one page
  - Pillar keyword + supporting long-tail variations = one URL
```

**Keyword Scoring Template:**

| Keyword | Monthly Volume | KD (0-100) | Intent | Funnel Stage | Priority |
|---------|----------------|------------|--------|-------------|---------|
| | | | Info/Comm/Trans | TOFU/MOFU/BOFU | H/M/L |

**Intent Types:**
- **Informational:** "how to X" / "what is X" → educational content, blog posts
- **Commercial:** "best X for Y" / "X vs. Y" → comparison pages, listicles
- **Transactional:** "buy X" / "X pricing" → product pages, pricing pages
- **Navigational:** "X login" / "X review" → brand-related, hard to rank for as non-brand

## Mode 2: On-Page SEO Checklist

For every page/article published:

```
TITLE TAG (50–60 chars)
  - Primary keyword as close to the start as possible
  - Compelling (include a benefit or differentiator)
  - Not truncated in SERPs
  Example: "How to Reduce Churn by 40% — [Brand] Guide"

META DESCRIPTION (150–160 chars)
  - Include primary keyword naturally
  - Include a CTA or benefit that increases CTR
  - Not duplicated from another page
  Example: "Learn the 5 retention tactics that reduced churn by 40% for 300+ SaaS companies. Free guide + templates."

H1 (one per page)
  - Contains primary keyword (exact or close variant)
  - Matches search intent
  - Different from title tag but aligned

URL STRUCTURE
  - Short and descriptive: /blog/reduce-churn-rate (not /blog/post-123)
  - Includes primary keyword
  - No dates in URL (content becomes outdated-looking)

CONTENT BODY
  - Primary keyword in first 100 words
  - H2/H3 headers include secondary keywords
  - Content length matches search intent (informational: 1500+ words; transactional: shorter)
  - Internal links: 3–5 to relevant pages on your site
  - External links: 2–3 to authoritative sources (builds trust)
  - Images: descriptive alt text including keyword

PAGE SPEED
  - Core Web Vitals: LCP <2.5s, FID <100ms, CLS <0.1
  - Image files optimized (WebP format, compressed)
  - Mobile-responsive (Google indexes mobile-first)

SCHEMA MARKUP
  - Article schema for blog posts
  - FAQ schema for how-to content
  - Product schema for product pages
  - Review schema where applicable
```

## Mode 3: Technical SEO Audit

Run this before investing in content creation:

```
CRAWLABILITY
  [ ] robots.txt allows Googlebot to crawl key pages
  [ ] XML sitemap submitted to Google Search Console
  [ ] No orphan pages (pages with no internal links)
  [ ] Canonical tags correct (no self-referencing canonicals on paginated pages)
  [ ] No redirect chains (301 → 301 → 301; should be 301 → final)

INDEXABILITY
  [ ] No important pages blocked by noindex
  [ ] No duplicate content (use canonical tags or 301s to consolidate)
  [ ] HTTP → HTTPS redirects working
  [ ] No soft 404s (pages that return 200 but say "page not found")

SITE SPEED (Google PageSpeed Insights)
  [ ] Mobile score > 70 (ideal > 90)
  [ ] Largest Contentful Paint (LCP) < 2.5 seconds
  [ ] Cumulative Layout Shift (CLS) < 0.1
  [ ] First Input Delay (FID) < 100ms

SITE ARCHITECTURE
  [ ] Max 3 clicks from homepage to any page
  [ ] Clear URL hierarchy (/category/subcategory/page)
  [ ] Breadcrumbs on deeper pages
  [ ] Internal linking flows from high-authority pages to new content

MOBILE
  [ ] Responsive design (tested on real mobile devices)
  [ ] Font size readable without zooming (16px+)
  [ ] Touch targets large enough (44×44px minimum)
```

## Mode 4: Link Building (Off-Page SEO)

Links are votes of authority. Without quality backlinks, even great content won't rank for competitive keywords.

**Strategies by effort/impact:**

| Strategy | Effort | Impact | How |
|----------|--------|--------|-----|
| Digital PR (data study / original research) | High | Very High | Publish original data; pitch journalists |
| Guest posting | Medium | High | Write for industry publications in your niche |
| HARO (Help a Reporter Out) | Low | Medium | Answer journalist queries as an expert source |
| Broken link building | Medium | Medium | Find broken links on authority sites; offer your content as replacement |
| Linkable asset creation | High | Very High | Tools, templates, free resources that naturally earn links |
| Competitor backlink replication | Low | Medium | Analyze where competitors get links; replicate |
| Community / Forum | Low | Low | Contribute genuinely; no spam |

**Link Quality Factors:**
- Domain Authority/Rating of linking site (use Ahrefs DR or Moz DA)
- Topical relevance (a link from a marketing blog to a marketing tool > link from a food blog)
- Link placement (in-content > sidebar > footer)
- Anchor text (descriptive > generic "click here")
- Follow vs. nofollow (follow passes link equity; nofollow does not)

## Mode 5: SEO Metrics & Reporting

```
SEO DASHBOARD — [Month]
──────────────────────────────────────────────────
ORGANIC TRAFFIC
  Sessions: [X] (↑/↓ Y% MoM)
  Organic Users: [X]
  Organic → Lead conversion: [X leads] ([Y%] rate)

KEYWORD RANKINGS (top 20 priority keywords)
  Keywords in position 1-3: [X]
  Keywords in position 4-10: [X]
  Keywords moved up this month: [X]
  Keywords moved down: [X]

CONTENT PERFORMANCE
  New articles published: [X]
  Top performing article (traffic): [URL]
  Top performing article (leads): [URL]

TECHNICAL HEALTH
  Crawl errors: [X] (target: 0)
  Indexed pages: [X]
  Core Web Vitals: [Pass/Fail per metric]

BACKLINKS
  New backlinks this month: [X]
  Total backlink count: [X]
  Top new referring domains: [List]
```

## Quality Gate

Before declaring SEO strategy complete:
- [ ] Technical SEO audit completed and critical issues resolved
- [ ] Keyword research done with intent classification (not just volume)
- [ ] Keyword clusters created (one cluster = one URL, not one keyword = one page)
- [ ] Topic cluster model defined (pillar page + 8–12 supporting articles)
- [ ] On-page SEO checklist applied to all priority pages
- [ ] Link building strategy defined with realistic timeline
- [ ] Google Search Console + GA4 verified and tracking
- [ ] SEO KPIs set: organic traffic target, ranking targets, conversion from organic
- [ ] Realistic timeline expectations set (6–12 months to see material results)
