import SwiftUI

/// Native-font typography helpers. Serif = New York (system), sans = SF Pro.
enum AppFont {
    static func serif(_ size: CGFloat, italic: Bool = false) -> Font {
        let base = Font.system(size: size, design: .serif)
        return italic ? base.italic() : base
    }

    static func sans(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight)
    }
}
