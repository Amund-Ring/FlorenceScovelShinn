import SwiftUI

/// Shared row used by Library and Saved screens.
/// Heart and "+" buttons are visual-only in M4; wired up in M6.
struct LibraryRow: View {
    @Environment(\.colorScheme) private var colorScheme
    let quote: Quote
    var isFavorite: Bool = false
    var isLast: Bool = false
    var onTap: (() -> Void)? = nil
    var onFavorite: (() -> Void)? = nil
    var onAddToToday: (() -> Void)? = nil

    var body: some View {
        let palette = CategoryColors.palette(for: quote.category)
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(palette.accent)
                    .frame(width: 3)
                    .frame(minHeight: 32)
                    .padding(.top, 3)

                VStack(alignment: .leading, spacing: 10) {
                    Text(quote.quote)
                        .font(AppFont.serif(14.5))
                        .lineSpacing(3)
                        .foregroundStyle(.primary)
                        .textSelection(.enabled)

                    HStack(alignment: .bottom, spacing: 6) {
                        CategoryPill(category: quote.category)
                        Text(quote.bookTitle)
                            .font(AppFont.sans(11))
                            .italic()
                            .foregroundStyle(AppTheme.textMuted(colorScheme))
                            .lineLimit(1)
                            .padding(.bottom, 2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 6) {
                    HeartButton(isFavorite: isFavorite, action: onFavorite ?? {})
                    PlusButton(action: onAddToToday ?? {})
                }
                .padding(.top, 2)
            }
            .padding(.vertical, 14)
            .contentShape(Rectangle())
            .onTapGesture { onTap?() }

            if !isLast {
                Divider().opacity(0.6)
            }
        }
    }
}

struct CategoryPill: View {
    @Environment(\.colorScheme) private var colorScheme
    let category: QuoteCategory

    var body: some View {
        let palette = CategoryColors.palette(for: category)
        Text(category.rawValue)
            .font(AppFont.sans(11, weight: .medium))
            .foregroundStyle(colorScheme == .dark ? palette.accent : palette.text)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                colorScheme == .dark
                    ? palette.accent.opacity(0.18)
                    : palette.background,
                in: Capsule()
            )
    }
}

private struct HeartButton: View {
    @Environment(\.colorScheme) private var colorScheme
    let isFavorite: Bool
    let action: () -> Void

    private var heartColor: Color {
        Color(red: 0.78, green: 0.40, blue: 0.40)  // ~oklch(62% 0.14 20)
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(isFavorite ? heartColor : AppTheme.textMuted(colorScheme))
                .frame(width: 30, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isFavorite
                              ? (colorScheme == .dark
                                 ? heartColor.opacity(0.16)
                                 : heartColor.opacity(0.10))
                              : AppTheme.card(colorScheme))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isFavorite ? heartColor : AppTheme.border(colorScheme), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

private struct PlusButton: View {
    @Environment(\.colorScheme) private var colorScheme
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppTheme.textMuted(colorScheme))
                .frame(width: 30, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.card(colorScheme))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(AppTheme.border(colorScheme), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}
