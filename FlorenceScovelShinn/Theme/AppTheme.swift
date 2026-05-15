import SwiftUI

/// App-wide background/foreground tokens, ported from js/theme.js (ivory + night).
enum AppTheme {
    static let ivoryBg     = Color(red: 0.980, green: 0.972, blue: 0.957)  // oklch(98% 0.008 60)
    static let nightBg     = Color(red: 0.121, green: 0.117, blue: 0.110)  // oklch(16% 0.015 60)

    static func screenBackground(_ scheme: ColorScheme) -> Color {
        scheme == .dark ? nightBg : ivoryBg
    }
}
