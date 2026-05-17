# App Store Launch Plan — Florence Scovel Shinn

End-to-end checklist for getting the app from "done in Xcode" to "live on the App Store."
Each section has a TLDR + open questions to discuss in detail.

---

## 0. Context — existing portfolio

Amund Ring is already a published App Store developer with three live apps and one bundle:

| App | Pricing | Category | Subtitle |
|---|---|---|---|
| Meditations by Marcus Aurelius | $7.99 one-time | Books | Timeless Stoic Wisdom |
| Letters from a Stoic | $7.99 one-time | Books | Stoic Letters by Seneca |
| ACIM Workbook | Free + subscription | Books | Workbook for Students |
| The Stoicism Bundle | $11.99 (saves $3.99 vs buying separately) | Books | — |

**ACIM uses a different model** — freemium with a subscription unlock (first 10 lessons free, one-week trial, then subscription for full access + audio + reminders). The Stoic apps are pure one-time purchases. This shows both models can coexist in the portfolio; we just need to pick one consciously for Florence.

**Note on portfolio evolution**: The existing three apps were built earlier with hybrid/web-wrapper approaches and have AI-generated descriptions from a few years back. Florence is the **first native iOS app** in the portfolio and represents a step up in polish. The plan is to eventually rebuild the existing apps as native and rewrite their descriptions to match Florence's new bar. So while we should be aware of the portfolio's current state, we don't need to constrain Florence's design or copy to match it — Florence is setting the new standard.

### Portfolio sales data (last 365 days)

| App | Revenue | Y-o-Y | Notes |
|---|---|---|---|
| ACIM Workbook (1-year subscription) | $1,110 | −18% | Subscription unlock |
| ACIM Workbook (1-month subscription) | $200 | −18% | Subscription unlock |
| Meditations by Marcus Aurelius | $415 | −30% | One-time $7.99 |
| The Stoicism Bundle | $207 | **+430%** | Bundle $11.99 |
| Letters from a Stoic | $16 | +121% | One-time $7.99 — but tiny absolute |
| **Total** | **~$1,940** | −13% | |

Active ACIM subscribers per RevenueCat: **38** (MRR ≈ $104, ARR ≈ $1.25K).

**Subscription trend**: ACIM peaked at ~60 subscribers and has gradually settled to ~40. Plateau, not crash — but no organic growth either. Reactivating subscriber growth is a planned future project (native rebuild + new paywalls + A/B testing). Until that lands, ACIM is "stable side income," not a growth engine.

**What this tells us:**

1. **Subscription is the clear revenue winner.** ACIM alone (≈$1.3K) earns more than both Stoic apps + bundle combined ($638). On a per-app basis, subscription wins by a wide margin.
2. **The Bundle is the standout growth story.** +430% Y-o-Y — customers who want one philosopher want both, and pricing the pair at $11.99 (instead of $15.98) closes the deal. This is the strongest case for bundling that we have data for.
3. **Solo Stoic sales are cannibalising into the bundle.** Letters dropped to almost nothing as a standalone ($16) but lives on through the bundle. Meditations also slipped (-30%) for the same reason. That's healthy — bundle revenue (+430%) more than offsets the solo dip.
4. **Marcus Aurelius >> Seneca as a standalone draw.** Meditations sells 26× more than Letters solo. Name recognition matters; people search "Marcus Aurelius" and "Meditations" specifically.
5. **The portfolio is trending down overall (-13%)** but is not in trouble — it's a small-but-stable revenue stream from older apps that haven't been updated. A polished new launch like Florence should reverse that trend.

**Implications for Florence's pricing decision:**

- **Subscription would likely earn more revenue**, but it introduces complexity (StoreKit, RevenueCat, subscriber support, churn management) and Florence's content is *finite* (a fixed set of quotes from public-domain books). Recurring value is harder to justify than ACIM's 365 daily lessons + audio + reminders.
- **$7.99 one-time** lines up with Meditations' ≈$415/year — a realistic baseline expectation. Not life-changing, but reliable.
- **Bundle potential is real**: if Florence ever pairs with a future "New Thought" app, the data says bundles work.

Pricing recommendation: **$7.99 one-time** still stands. Florence isn't a natural subscription product. Save subscriptions for apps where you're adding ongoing value (audio, lessons, sync).

**Strategic framing**: Two viable paths to grow portfolio revenue:
1. **Optimise existing apps** — rebuild ACIM native, redesign paywalls, A/B test, try to reverse the subscriber plateau. High effort, uncertain ROI.
2. **Ship more apps** — each one adds an independent revenue stream. Florence is the first move in this strategy. Future apps in the same genre (New Thought, devotional content) can compound via bundling.

You're doing both. Florence is the path-2 piece; the eventual ACIM native rebuild is the path-1 piece. Both should happen, but Florence ships first because it's done and shipping is the highest-ROI action you can take right now.

**Patterns from the existing portfolio that we should follow (or intentionally diverge from):**

- **Category**: All apps use **Books**. Florence Scovel Shinn fits the same pattern.
- **Subtitle style**: short, descriptor-of-content phrasing (3–5 words).
- **Pricing for paid apps**: $7.99 — premium-content tier. Signals "this is a curated experience, not just a quote generator." Customers willing to pay this price tend to be invested in the content and leave better reviews than freemium audiences.
- **Audience**: spiritual / philosophical reading content.
- **Visual identity for icons**: blue/dark backgrounds with yellow borders. **Florence diverges** (ivory + gold serif typography), which is intentional and matches the content's softer aesthetic — Shinn's New Thought writing has a more "devotional" feel than Stoic philosophy.

**Bundle consideration for later**: Florence could anchor a future **"New Thought" / "Spiritual Wisdom" bundle** alongside any future apps in the same genre, the way Marcus Aurelius + Seneca pair into the Stoicism Bundle today. Not a launch-week task, but worth noting.

---

## 1. Prerequisites — ✓ already in place

- ✓ Apple Developer Program enrolled.
- ✓ Personal account (Amund Ring as Seller name).
- ✓ App Store Connect access, payment/tax info configured.
- ✓ Familiar with the submission flow (3 apps already shipped).

Nothing to set up. We can go straight to creating the new app record in App Store Connect when we're ready.

---

## 2. App identity

| Field | Value | Limit | Notes |
|---|---|---|---|
| Bundle ID | `com.amundring.florencescovelshinn` | locked | ✓ Decided. Can't change after first submission. |
| App name (store listing) | `Florence Scovel Shinn` | 30 chars | ✓ Decided. |
| Display name (home screen) | `Florence` | 12 chars | ✓ Decided. Friendly, intimate, no truncation. |
| Subtitle | *TBD — settle when writing description* | 30 chars | Highest SEO impact field. |
| App Store category — primary | `Books` | one choice | ✓ Decided. Matches portfolio + cross-sell. |
| App Store category — secondary | `Lifestyle` | one choice | ✓ Decided. Captures daily-companion use case. |

### Category analysis (kept for reference)
*Decision above. Reasoning below.*


Apple's app categories (non-game) are: Books, Business, Developer Tools, Education, Entertainment, Finance, Food & Drink, Graphics & Design, Health & Fitness, Lifestyle, Kids, Magazines & Newspapers, Medical, Music, Navigation, News, Photo & Video, Productivity, Reference, Shopping, Social Networking, Sports, Travel, Utilities, Weather.

Realistic candidates for this app:

| Category | Fit | Discoverability |
|---|---|---|
| **Books** | Content origin matches (quotes from her published books) | Familiar audience from your existing portfolio. Buyers who browse your developer page already trust this category. |
| **Lifestyle** | Daily wisdom / spiritual living is exactly the Lifestyle bucket. Affirmation apps (I Am, Mindful) and "daily inspiration" apps live here. | Bigger, more crowded category — harder to rank but bigger total audience. |
| **Reference** | The Library + search/filter make it function as a reference. | Smaller category, easier to rank. Audience expects "look something up" tools. |
| **Health & Fitness** | Some affirmation/mindfulness apps cluster here. | Crowded with wellness-industrial-complex apps; might feel like a stretch. |

**You're right that this one is genuinely different from your other apps.** Marcus Aurelius / Seneca / ACIM are "read the whole book" apps — Books is exact. Florence is "dip into curated quotes daily, organized by theme" — that's more Lifestyle / Daily companion than Books.

**My recommendation**:
- **Primary: Lifestyle.** It matches how the app is *used* (daily wisdom dose, mood-based filtering, save what resonates) rather than where the content *came from*. Affirmation/inspiration apps almost universally live here.
- **Secondary: Books.** Captures the content origin and benefits from cross-traffic with your existing apps. Buyers on your developer page browsing your Stoicism apps will see Florence and feel the family resemblance.

**Alternative** if you want to mirror the rest of the portfolio:
- Primary: Books, Secondary: Lifestyle. Safer for cross-sell, slightly weaker fit for new-discovery.

Both are defensible. I lean Lifestyle-primary because the app's gestures (3 cards a day, swipe through quotes, save favorites) point at "daily companion" more than "reading a book."

---

## 3. Marketing copy

Three pieces of copy you'll need to write:

**Promotional text** — 170 chars, can be updated without a new build. Use for timely news ("New quotes added!", seasonal messages).

**Description** — 4,000 chars. The long pitch. Only the first 2–3 lines are visible before "more" — front-load value.

**Keywords** — 100 chars total, comma-separated, no spaces. Critical for search. Examples: `quotes,affirmations,spiritual,stoic,daily,wisdom,manifestation,florence,scovel,shinn,faith,abundance`

### Approach for Florence

Writing fresh. The existing portfolio's descriptions were AI-generated years ago and aren't a template to copy — they're background context only. Those apps will be rewritten when they're rebuilt as native iOS apps.

For Florence's description we want:
- **Tight** — every sentence earns its place.
- **Distinctive** — matches the softer, devotional aesthetic of the app itself.
- **Front-loaded** — the first 2 lines (the only ones visible before "more") have to land.

**Decisions**
- ✓ **Target audience**: broader spirituality / manifestation / affirmations seekers. Lead with what the app *does* for them (mindset shifts, daily wisdom for manifestation work), not who Shinn was. Shinn-aware buyers will find the app anyway via name search — we don't need to optimize for them.
- ✓ **Feature emphasis**: lead with benefits in the first 2 lines; include features in the body of the description (not the lead). Features are simple enough to all fit.
- ⏳ **Tone**: see options below.

### Tone options

Four directions, ranked by how well I think they fit the app's existing visual identity:

1. **Warm & encouraging** *(my recommendation)*
   > "Start each day with words that remind you what's possible. Florence Scovel Shinn's timeless teachings — faith, abundance, mindset, love — ready whenever you need them."

   Friendly, accessible, matches the ivory/gold/serif aesthetic of the app itself. Wide appeal without being generic.

2. **Quiet & contemplative**
   > "A quiet space to return to. Florence Scovel Shinn's words, organised for daily reflection."

   Literary, restrained. Beautiful but might be too understated for impulse browsers on the App Store.

3. **Direct & action-oriented**
   > "Shift your mindset in 30 seconds. Three daily affirmations from Florence Scovel Shinn's spiritual classics, by mood and theme."

   Punchy, benefit-forward, more aligned with mainstream manifestation app copy ("I Am", "ThinkUp"). Highest conversion potential, lowest brand distinctiveness.

4. **Devotional & reverent**
   > "Words that have guided seekers for nearly a century. Now in your pocket."

   Treats Shinn as venerable. Beautiful for the right audience but risks alienating manifestation-curious buyers who'd find it too "spiritual" in a religious sense.

My recommendation: **#1 (Warm & encouraging)**. It opens the door to both audiences (the seeker who knows manifestation language, and the contemplative reader who wants beauty) without committing to either extreme. The app's visual identity is warm + literary, not punchy or austere — copy should echo that.

**Note on SEO**: Manifestation, affirmations, mindset keywords don't all need to live in the description. They go in the **Keywords field** (100 chars, separate from description). That frees the description to be human and well-written rather than keyword-stuffed.

**Decision**
- ✓ **Tone**: #1 (Warm & encouraging). #2 "quiet/contemplative" rejected — doesn't match Shinn's actual writing, which is **active and agentic** (declarations, affirmations, "Infinite Spirit, open the way"). The copy should carry that energy of trust and active faith, not passive reflection.

### Draft v1

**Subtitle (30 char max)** — five options, pick later:

| # | Option | Chars | Angle |
|---|---|---|---|
| 1 | `Daily wisdom for manifestation` | 30 | SEO-leaning. Two big search words. |
| 2 | `Shift your mindset, every day` | 29 | Active, benefit-forward. Echoes the action-oriented tone of #3. |
| 3 | `Words for faith & abundance` | 27 | Warm, uses Shinn's own thematic vocabulary. |
| 4 | `Three quotes to start your day` | 30 | Feature-led. Tells the user exactly what they get. |
| 5 | `Affirmations for inspired days` | 30 | Upbeat, broad appeal, mainstream. |

**Promotional text (170 char max)** — updateable without a new build:

> Three quotes a day. Save the ones that move you. Florence Scovel Shinn's timeless words on faith, abundance, mindset, and love — ready whenever you need them.

(149 chars)

**Description (draft v2)**:

> **A focused way to work with Florence Scovel Shinn's wisdom.**
>
> Three quotes a day from her four published books. Lock the ones that resonate, refresh the ones that don't, and keep your favorites within reach.
>
> **About Florence Scovel Shinn**
>
> A pioneer of New Thought, Shinn taught that the spoken word has creative power and that manifestation begins with affirmation. Her four books — *The Game of Life and How to Play It*, *Your Word Is Your Wand*, *The Secret Door to Success*, and *The Power of the Spoken Word* — have guided seekers for nearly a century.
>
> Her writing is rich with quotes worth living with. But her books are dense, and choosing which few to focus on each day can feel overwhelming. This app does that for you.
>
> **How you'll use it**
>
> • **Today** — three quotes chosen for you each day. Lock the ones that resonate so they stay. Refresh the rest when you want something new.
> • **Library** — quotes from Shinn's published works in one place. Filter by theme or book. Search anything.
> • **Saved** — keep the words that move you, ready to revisit.
> • **Focus mode** — tap any quote to read it full-screen, free of distractions. Swipe through your day's set.
> • **Light and dark** — follow your phone, or set it yourself.
>
> **Privacy**
>
> No accounts. No tracking. No data leaves your device.

(≈1,250 chars, well under the 4,000 limit. Opens with the curation promise — solving the "too many quotes" problem that anyone who's read Shinn knows.)

**Keywords (100 char max, comma-separated, no spaces)**:

`affirmations,manifestation,abundance,faith,mindset,daily,prosperity,lawofattraction,quotes,spiritual`

(99 chars, 10 keywords. Covers the big-search terms — `manifestation`, `lawofattraction`, `affirmations`, `quotes` — plus Shinn-thematic terms — `abundance`, `faith`, `mindset`, `prosperity`, `spiritual`. Drops `florence` and `shinn` because the app name already covers them.)

**Status**

- ✓ Description v2 locked. Re-read before submission but no changes planned.
- ✓ Keywords locked: `affirmations,manifestation,abundance,faith,mindset,daily,prosperity,lawofattraction,quotes,spiritual`
- ⏳ Subtitle: 5 options listed above, pick later.

---

## 4. Visual assets

**App icon** — done ✓

**Screenshots** — required, multiple device sizes. iOS 17+ accepts:
- 6.9" iPhone (iPhone 16 Pro Max): **1320 × 2868**
- 6.5" iPhone (iPhone 11 Pro Max): **1242 × 2688** (optional fallback)
- iPad Pro 12.9" (3rd gen): **2048 × 2732** (only if shipping iPad)

You need **2–10** screenshots per device size. Most polished apps use 4–6.

Recommended set for this app:
1. Today screen with 3 quotes (the hero shot)
2. Focus mode showing a full quote (the "wow" moment)
3. Library with filter chips open (showing breadth of content)
4. Saved screen (personalization)
5. Today screen in dark mode (showing both themes)

Each screenshot can have an overlay caption (added in App Store Connect). Many apps include short marketing text on the screenshots themselves — Apple has gone back and forth on this.

**App preview video** — optional. 15–30 sec, in portrait. Demonstrably increases install rate but takes real effort to produce. Worth considering for v2.

### Tool: AppScreens.com ✓

Decided to use [AppScreens.com](https://appscreens.com) — generates polished App Store screenshots with device frames, caption text, and styled backgrounds. The "designed promotional shot" route, not raw device screenshots.

**What still needs deciding**

- **Backgrounds**: solid color, gradient, or branded pattern? Ivory or warm cream feels on-brand for Florence; a soft gold gradient could feel premium.
- **Caption text** for each of the 5 screenshots (one short line per shot, ~5-8 words):
  - Today: e.g. *"Three quotes a day."*
  - Focus mode: e.g. *"Read in calm focus."*
  - Library: e.g. *"Every quote, organized."*
  - Saved: e.g. *"Keep the words that move you."*
  - Today dark mode: e.g. *"Light or dark, your choice."*
- **Light/dark mix**: I'd suggest 4 light + 1 dark (the last one, to subtly advertise dark mode without making the whole page feel gloomy).
- **Order**: Today → Focus → Library → Saved → Today (dark) feels right. Today first because it's the hero shot.

Tackle these once you're ready to generate screenshots in AppScreens.

---

## 5. Age rating & content

App Store requires an age-rating questionnaire. For this app, the answer is "4+" — no objectionable content, no in-app purchases, no third-party ads, no user-generated content.

Quick to fill out, no decisions needed.

---

## 6. Pricing & monetization

Three viable models for a single-author quote app:

| Model | Pros | Cons |
|---|---|---|
| **Free** | Largest audience, lowest friction | Zero revenue, need other motivation to maintain. |
| **Paid one-time** ($0.99 – $4.99) | Simple, no IAP complexity, fair exchange | Smaller audience, harder discovery. |
| **Free + tip jar** | Friendly, lets fans support | Most users tip nothing; tip jars often raise < $20/month. |
| **Free + Pro IAP** | Try-before-buy | Locking features feels stingy for content-only apps. |

**Comparable apps:**
- *Daily Stoic* — free with $4.99/mo subscription
- *Insight Timer* — free with optional premium
- *Quotefancy* — free with ads
- *I Am – Daily Affirmations* — free + $19.99/year subscription
- *Carrot Quotes* — $2.99 one-time
- *Amund Ring's existing apps* — $7.99 one-time

**My recommendation**: **$7.99 one-time**, matching the existing portfolio.

Reasons to keep it consistent:
- Customers browsing your developer page see one coherent price point — feels intentional, not random.
- $7.99 is a "premium-content" anchor that filters for engaged readers. They leave better reviews and complain less.
- If you ever do a Spiritual Wisdom bundle (Florence + future apps), pricing them all at $7.99 means the bundle discount math is clean.
- Easier to *raise* from $7.99 than to lower then raise back. Don't undercut yourself.

Reasons to consider a different number:
- If you want this app to be the "entry drug" that introduces people to your portfolio, a lower price ($2.99 or $3.99) could justify itself. But your existing model clearly works without that.

**Open questions**
- Stick with $7.99, or experiment?
- App Store takes 30% (or 15% if revenue < $1M/year via the Small Business Program — applies to you).
- Pricing tiers are global; Apple handles currency conversion automatically.

---

## 7. Privacy & legal

**Privacy nutrition label** — ✓ "Data Not Collected." Local-only state (SwiftData, UserDefaults). No analytics, no accounts, no network requests, no third-party SDKs.

**Privacy Policy URL** — ✓ Reuse the same privacy policy URL already used by Amund Ring's existing apps. Content is identical: "This app does not collect, transmit, or share any personal data. All your favorites and preferences stay on your device."

**Content rights** — ✓ Florence Scovel Shinn died in **1940**. Her four published books (1925, 1928, 1940, posthumously 1945) are in the **public domain** in the US and in most jurisdictions following life + 70/95 year rules. No licensing needed, no permissions sought, no royalties owed.

---

## 8. TestFlight — personal use only ✓

Skipping external beta testers. Will use TestFlight purely for personal multi-device testing (iPhone Air, iPhone 17, iPhone 12 mini, etc.) before public submission. Apple still requires the app to be uploaded to App Store Connect to install via TestFlight, but no public beta invites needed.

This means: archive the build, upload it, install on each personal test device, verify everything works in production-mode (not debug-mode) on each, then submit.

---

## 9. Submission & review

### The big risk: Guideline 4.2 — Minimum Functionality

Letters from a Stoic was almost certainly rejected the first time under **App Review Guideline 4.2**: Apple thinks "content-only apps" (a book displayed on a screen, a list of quotes) lack the functionality required for the App Store and belongs in Apple Books instead.

This is the single highest rejection risk for Florence. To preempt it:

1. **Use the App Review Notes field** (private message to Apple, in App Store Connect → App Information → App Review Information → Notes). This is *the* most underused field by indie developers. Most developers leave it blank — but a well-written note can prevent rejection entirely by explaining functionality before the reviewer needs to discover it.

2. **Lean on the precedent**: three similar apps from the same developer are already approved and live. Apple's reviewers can see this.

3. **Frame Florence as an interactive tool, not a quote collection**. Emphasize the curation, lock/refresh slot system, multi-mode filtering, favorites, focus mode, animations. These are real interaction features that distinguish it from a passive book.

### Draft App Review Notes

Pre-written for the App Review Information field:

> Hello App Review Team,
>
> This is an interactive daily companion built around the public-domain writings of Florence Scovel Shinn (1871–1940), a New Thought author whose works have been in the public domain for over 80 years.
>
> The app is not a passive quote display. It includes:
>
> - A daily curation system that surfaces 3 quotes per day, each with individual lock/refresh controls so the user can keep what resonates and discard what doesn't
> - A full searchable library of quotes from her four published works, with filtering by category (Faith, Abundance, Mindset, Love) and by book, plus three sort modes
> - A user-managed favorites collection with date-added sorting and the same filtering controls
> - A full-screen focus mode with horizontal swipe navigation between quotes
> - Native iOS animations including symbol effects, tactile press feedback, and content crossfades
> - Light/dark/system appearance modes
>
> All user state (favorites, view counts) is stored locally on-device using SwiftData. The app collects no data, has no accounts, requires no network connection, and contains no third-party SDKs or analytics.
>
> For context, I have three other apps already on the App Store under this developer account:
>
> - Meditations by Marcus Aurelius (App ID 6476632120)
> - Letters from a Stoic (App ID 6736611477)
> - ACIM Workbook (App ID 6443900608)
>
> This is the first app I've built natively for iOS using SwiftUI.
>
> Thank you for reviewing.

### Submission steps

1. Lock in the subtitle.
2. Generate screenshots in AppScreens.com.
3. Confirm the privacy policy URL works (the existing one).
4. Archive release build in Xcode (`Product → Archive`).
5. Upload to App Store Connect via Organizer.
6. Create the app record in App Store Connect, fill in all metadata.
7. Paste the App Review Notes into the App Review Information field.
8. Attach build, set pricing ($7.99), set release strategy.
9. Submit for review.
10. Typical wait: 24–72 hours.

### Release strategy

- ✓ **Manual release recommended**: click to release after approval. Lets you pick a calm moment to launch rather than a surprise.

### If rejected anyway

You've been through this before with Letters from a Stoic. The workflow:
1. Read the rejection carefully — Apple cites the specific guideline.
2. Reply via the Resolution Center in App Store Connect. Don't argue — explain. Reference the App Review Notes, point out the three existing approved apps from the same developer, and detail any specific interactivity the reviewer may have missed.
3. Most 4.2 rejections are overturned on appeal if the app genuinely has the functionality. Yours does.

---

## 10. Post-launch

Things to think about once it's live:
- **Reviews & ratings**: respond to negative reviews professionally; consider adding a "rate this app" prompt after 10–20 sessions.
- **Updates**: every version requires a new build + review. Plan for at least one v1.1 bug-fix release within 2–3 weeks of launch.
- **Analytics**: App Store Connect provides install/sales analytics. If you want richer in-app analytics, you'd need to add a privacy-friendly tool — but for v1, the built-in ones are likely enough.
- **Marketing**: a personal website / Twitter / Reddit post in r/Stoicism, r/spirituality, etc. can drive early discovery. Press release if you're feeling ambitious.

---

## Suggested order of next conversations

1. **App identity** — lock in subtitle, display name, categories.
2. **Marketing copy** — draft description + keywords together.
3. **Screenshots** — decide on style, generate them.
4. **Pricing** — commit to a model.
5. **Privacy policy** — write the page + host it.
6. **TestFlight setup** + small beta round (optional).
7. **Submission**.

Tell me which one to dig into first.
