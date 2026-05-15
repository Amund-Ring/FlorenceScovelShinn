import SwiftUI

// ─── QUOTE FONT — pick one ─────────────────────────────────────────
// Comment/uncomment to compare. All are pre-installed on iOS.
//
//   .newYork  — current. System serif. Modern, neutral, slightly geometric.
//   .georgia  — warm, sturdy, classic web serif. Slightly bookish.
//   .charter  — transitional serif designed for screens. Friendly, readable.
//   .palatino — elegant humanist serif. Calligraphic feel.
//   .didot    — high-contrast modern serif. Dramatic, fashion-magazine feel
//               (closest in spirit to DM Serif Display).
//
private let quoteFontChoice: QuoteFontChoice = .newYork
//private let quoteFontChoice: QuoteFontChoice = .georgia
//private let quoteFontChoice: QuoteFontChoice = .charter
//private let quoteFontChoice: QuoteFontChoice = .palatino
//private let quoteFontChoice: QuoteFontChoice = .didot
// ───────────────────────────────────────────────────────────────────

enum QuoteFontChoice {
    case newYork, georgia, charter, palatino, didot
}

enum AppFont {
    /// Serif used for quote text and the "Today" title.
    static func serif(_ size: CGFloat, italic: Bool = false) -> Font {
        switch quoteFontChoice {
        case .newYork:
            let base = Font.system(size: size, design: .serif)
            return italic ? base.italic() : base
        case .georgia:
            return .custom(italic ? "Georgia-Italic" : "Georgia", size: size)
        case .charter:
            return .custom(italic ? "Charter-Italic" : "Charter", size: size)
        case .palatino:
            return .custom(italic ? "Palatino-Italic" : "Palatino", size: size)
        case .didot:
            return .custom(italic ? "Didot-Italic" : "Didot", size: size)
        }
    }

    /// Sans (SF Pro) for all UI chrome.
    static func sans(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight)
    }
}
