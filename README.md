# Florence Scovel Shinn

Native iOS app — a daily companion for the writings of Florence Scovel Shinn.
Three quotes a day, a searchable library of the full corpus, and a saved
collection you build over time.

A port of the [PWA version](https://github.com/amundring/Florence-Scovel-Shinn)
to native SwiftUI for a smoother, sturdier mobile experience.

## Status

In progress. Built phase by phase:

- [x] **M1** — Data foundation (models, JSON loader, SwiftData)
- [x] **M2** — Today screen (3 slots, lock/refresh, weighted picker)
- [x] **M3** — Today polish (typography, colors, dark mode)
- [x] **M4** — Tab bar + Library skeleton
- [x] **M5** — Library filters & sort
- [ ] **M6** — Favorites / Saved screen
- [ ] **M7** — Focus mode (full-screen swipeable viewer)
- [ ] **M8** — Polish, app icon, final pass

## Stack

- SwiftUI, iOS 17.6+
- SwiftData for per-quote user state (favorites, times shown, last shown)
- `@AppStorage` for simple preferences and the Today slot state
- Native fonts (system serif + SF Pro) — no bundled font assets

## Project layout

```
FlorenceScovelShinn/
  Models/         Quote, Book, QuoteCategory, QuoteUserState
  Data/           QuoteStore (loads quotes.json, weighted picker)
  Theme/          AppTheme, CategoryColors, Typography
  Today/          Today screen + slot state
  quotes.json     Source of truth for all quote content
```

The 250+ quotes in `quotes.json` are the single source of truth. User data
(favorites, view counts) lives in SwiftData and is keyed to quote IDs, so
quote content can be updated without affecting user state.

## Build & run

1. Open `FlorenceScovelShinn.xcodeproj` in Xcode 15+.
2. Pick an iPhone simulator (or your device).
3. Cmd+R.
