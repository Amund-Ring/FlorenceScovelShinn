import SwiftUI

/// sRGB approximations of the PWA's OKLCH category palette (js/theme.js).
struct CategoryPalette {
    let accent: Color       // oklch(~58% 0.10 H)  (Abundance: 68% 0.12)
    let background: Color   // oklch(96% 0.03 H)
    let text: Color         // oklch(~38% 0.10 H)
}

enum CategoryColors {
    static func palette(for category: QuoteCategory) -> CategoryPalette {
        switch category {
        case .abundance:
            // hue 75 — warm amber
            return CategoryPalette(
                accent:     Color(red: 0.784, green: 0.580, blue: 0.275),
                background: Color(red: 0.965, green: 0.937, blue: 0.886),
                text:       Color(red: 0.420, green: 0.290, blue: 0.075)
            )
        case .faith:
            // hue 155 — green
            return CategoryPalette(
                accent:     Color(red: 0.365, green: 0.584, blue: 0.475),
                background: Color(red: 0.910, green: 0.957, blue: 0.925),
                text:       Color(red: 0.114, green: 0.286, blue: 0.208)
            )
        case .mindset:
            // hue 285 — purple
            return CategoryPalette(
                accent:     Color(red: 0.522, green: 0.478, blue: 0.722),
                background: Color(red: 0.929, green: 0.918, blue: 0.961),
                text:       Color(red: 0.243, green: 0.208, blue: 0.408)
            )
        case .love:
            // hue 25 — red/rose
            return CategoryPalette(
                accent:     Color(red: 0.722, green: 0.404, blue: 0.404),
                background: Color(red: 0.961, green: 0.918, blue: 0.910),
                text:       Color(red: 0.435, green: 0.157, blue: 0.157)
            )
        }
    }
}
