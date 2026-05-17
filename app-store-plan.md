# App Store Launch Plan — Florence Scovel Shinn

End-to-end checklist for getting the app from "done in Xcode" to "live on the App Store."
Each section has a TLDR + open questions to discuss in detail.

---

## 1. Prerequisites

**Apple Developer Program** — $99/year. Required to publish anything to the App Store.
- Sign up at [developer.apple.com/programs](https://developer.apple.com/programs/).
- Use the same Apple ID you intend to publish under.
- Approval typically takes 24–48 hours.

**App Store Connect** — your dashboard for managing the app listing, builds, pricing, screenshots, etc. Free once you're enrolled in the Developer Program.

**Open questions**
- Already enrolled, or do we need to start the signup?
- Personal account or legal entity? (Affects "Seller" name shown on the store. Personal = your name. Entity = company name, requires D-U-N-S number, more setup.)

---

## 2. App identity

| Field | Value (current draft) | Limit | Notes |
|---|---|---|---|
| Bundle ID | `com.amundring.florencescovelshinn` | locked | Can't change after first submission. |
| App name | `Florence Scovel Shinn` | 30 chars | Shown on home screen + store listing. |
| Subtitle | *TBD* | 30 chars | Shown under name in search results. Big SEO impact. |
| Display name (home screen) | *Same as App name?* | 12 chars before truncating | Could be shorter ("FSS"? "Shinn"?) — see open Q. |
| App Store category — primary | *TBD* | one choice | Likely Lifestyle or Reference. |
| App Store category — secondary | *TBD* | one choice | Books? Health & Fitness? |

**Open questions**
- Subtitle ideas to brainstorm. Examples: "Daily wisdom & affirmations", "Quotes for spiritual practice", "Florence Scovel Shinn's teachings, on your phone".
- Is "Florence Scovel Shinn" the right home-screen name, or do we want something shorter that fits without truncation under the icon?
- Lifestyle vs Reference vs Books — they affect discovery patterns.

---

## 3. Marketing copy

Three pieces of copy you'll need to write:

**Promotional text** — 170 chars, can be updated without a new build. Use for timely news ("New quotes added!", seasonal messages).

**Description** — 4,000 chars. The long pitch. Only the first 2–3 lines are visible before "more" — front-load value.

**Keywords** — 100 chars total, comma-separated, no spaces. Critical for search. Examples: `quotes,affirmations,spiritual,stoic,daily,wisdom,manifestation,florence,scovel,shinn,faith,abundance`

**Open questions**
- Who's the target audience? Existing Shinn readers, or broader spirituality/self-help audience?
- Do we mention specific feature names ("Today screen", "Focus mode") or keep it benefit-focused?
- Tone: contemplative & literary, or more action-oriented ("start your day with…")?

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

**Open questions**
- Should screenshots include marketing captions ("Quotes for every mood", etc.) or be pure UI?
- Light, dark, or mixed?
- Do we want a custom screenshot template (e.g. floating device on a colored background), or just clean screenshots straight from the device?

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

**My recommendation**: **$1.99 one-time** or **free with tip jar**.

- $1.99 is "almost free" psychologically, but signals quality. Generates real revenue if even a few hundred people buy.
- Tip jar is friendlier if this is more a labor of love than a commercial endeavor.

**Open questions**
- Personal project (free) or income generator (paid)?
- App Store takes 30% (or 15% if revenue < $1M/year via the Small Business Program — likely you).
- Pricing tiers are global; Apple handles currency conversion automatically.

---

## 7. Privacy & legal

**Privacy nutrition label** — declares what data the app collects. For this app:
- Local-only data (SwiftData, UserDefaults). No analytics. No accounts. No network requests.
- Declaration: "Data Not Collected." Simplest possible label — a green flag for privacy-conscious users.

**Privacy Policy URL** — required even if you collect nothing. Can be a single static HTML page.
- Simplest path: a one-page GitHub Pages site or Notion page.
- Sample text: "This app does not collect, transmit, or share any personal data. All your favorites and preferences stay on your device."

**Content rights** — Florence Scovel Shinn died in **1940**. Her works are in the **public domain** in the US (life + 95 years for pre-1978 works, in some calculations; her published books from 1925/1928/1940 are clearly PD now). No licensing needed. Worth a one-liner in the description ("All quotes from her published works, in the public domain").

**Open questions**
- Comfortable using a personal Notion / GitHub Pages link for the Privacy Policy?
- Any concerns about which jurisdictions' PD status might differ?

---

## 8. TestFlight (optional but recommended)

Free beta-testing infrastructure built into App Store Connect. Lets you distribute pre-release builds to up to 10,000 testers via email invite or public link.

Why it's worth doing:
- Catches device-specific bugs (like the iPhone Air @AppStorage animation issue we hit).
- Lets a few trusted friends/family use the app for a week before public launch.
- Doesn't count against your App Store review queue.

Cost: zero.

**Open questions**
- Want to do a small TestFlight round (5–10 people) before public submission, or go straight to public release?

---

## 9. Submission & review

After everything above is filled in:
1. Archive a release build in Xcode (`Product → Archive`).
2. Upload to App Store Connect via the Organizer window.
3. Attach the build to your app version, complete all metadata, submit for review.
4. Review typically takes 24–72 hours.
5. Common rejection reasons: missing privacy policy URL, app crashes on launch, broken links in metadata, screenshots that don't represent the app.

**Release strategy** — two options:
- **Automatic**: app goes live the moment Apple approves.
- **Manual**: you click a button to release after approval. Useful for coordinated launches.

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
