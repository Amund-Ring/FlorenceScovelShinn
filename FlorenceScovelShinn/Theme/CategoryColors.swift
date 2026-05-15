import SwiftUI

/// sRGB approximations of the PWA's OKLCH category palette (js/theme.js).
/// Refined visually in M3; values here are close enough for M1/M2.
struct CategoryPalette {
    let accent: Color
    let background: Color
    let text: Color
}

enum CategoryColors {
    static func palette(for category: QuoteCategory) -> CategoryPalette {
        switch category {
        case .abundance:
            return CategoryPalette(
                accent:     Color(red: 0.80, green: 0.60, blue: 0.30),
                background: Color(red: 0.97, green: 0.94, blue: 0.88),
                text:       Color(red: 0.45, green: 0.32, blue: 0.10)
            )
        case .faith:
            return CategoryPalette(
                accent:     Color(red: 0.36, green: 0.60, blue: 0.46),
                background: Color(red: 0.90, green: 0.96, blue: 0.92),
                text:       Color(red: 0.18, green: 0.36, blue: 0.24)
            )
        case .mindset:
            return CategoryPalette(
                accent:     Color(red: 0.52, green: 0.48, blue: 0.72),
                background: Color(red: 0.93, green: 0.92, blue: 0.97),
                text:       Color(red: 0.30, green: 0.26, blue: 0.46)
            )
        case .love:
            return CategoryPalette(
                accent:     Color(red: 0.74, green: 0.40, blue: 0.40),
                background: Color(red: 0.97, green: 0.92, blue: 0.91),
                text:       Color(red: 0.48, green: 0.20, blue: 0.20)
            )
        }
    }
}
