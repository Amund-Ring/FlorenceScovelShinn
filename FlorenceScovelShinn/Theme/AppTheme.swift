import SwiftUI

/// App-wide tokens ported from js/theme.js (ivory + night).
/// OKLCH values converted to approximate sRGB.
enum AppTheme {
    // Backgrounds
    static let ivoryBg     = Color(red: 0.980, green: 0.972, blue: 0.957)  // oklch(98% 0.008 60)
    static let ivoryCard   = Color.white                                    // #ffffff
    static let nightBg     = Color(red: 0.121, green: 0.117, blue: 0.110)  // oklch(16% 0.015 60)
    static let nightCard   = Color(red: 0.176, green: 0.169, blue: 0.157)  // oklch(22% 0.015 60)

    static let ivoryBorder = Color(red: 0.810, green: 0.800, blue: 0.785)  // 84% — clearly visible
    static let nightBorder = Color(red: 0.286, green: 0.278, blue: 0.263)  // oklch(28% 0.015 60)

    // Text
    static let ivoryTextSecondary = Color(red: 0.612, green: 0.601, blue: 0.585)  // oklch(60% 0.015 60)
    static let ivoryTextLabel     = Color(red: 0.500, green: 0.490, blue: 0.475)  // oklch(52% 0.015 60) — for section labels
    static let ivoryTextMuted     = Color(red: 0.667, green: 0.655, blue: 0.638)  // oklch(65% 0.015 60)
    static let nightTextSecondary = Color(red: 0.632, green: 0.621, blue: 0.601)  // oklch(62% 0.015 60)
    static let nightTextLabel     = Color(red: 0.730, green: 0.720, blue: 0.700)  // oklch(73% 0.012 60) — for section labels
    static let nightTextMuted     = Color(red: 0.555, green: 0.546, blue: 0.529)  // oklch(55% 0.012 60)

    // Scheme-aware accessors
    static func background(_ s: ColorScheme) -> Color { s == .dark ? nightBg : ivoryBg }
    static func card(_ s: ColorScheme)       -> Color { s == .dark ? nightCard : ivoryCard }
    static func border(_ s: ColorScheme)     -> Color { s == .dark ? nightBorder : ivoryBorder }
    static func textLabel(_ s: ColorScheme)  -> Color { s == .dark ? nightTextLabel : ivoryTextLabel }
    static func textMuted(_ s: ColorScheme)  -> Color { s == .dark ? nightTextMuted : ivoryTextMuted }
}
