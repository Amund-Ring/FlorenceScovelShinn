import SwiftUI

/// The collapsible filter/sort panel that lives under the screen header.
struct FilterControls: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var filters: LibraryFilters
    let forSaved: Bool

    private let allCategories = ["All"] + QuoteCategory.allCases.map(\.rawValue)
    private let allBooks: [(id: String, label: String)] = [
        ("All", "All")
    ] + Book.allCases.map { (id: $0.rawValue, label: $0.shortLabel) }

    var body: some View {
        VStack(spacing: 0) {
            chipSection(label: "Category") {
                ForEach(allCategories, id: \.self) { id in
                    chip(label: id, isActive: filters.category == id) {
                        filters.category = id
                    }
                }
            }
            Divider().opacity(0.8)
            chipSection(label: "Book") {
                ForEach(allBooks, id: \.id) { item in
                    chip(label: item.label, isActive: filters.book == item.id) {
                        filters.book = item.id
                    }
                }
            }
            Divider().opacity(0.8)
            chipSection(label: "Sort by") {
                ForEach(SortMode.allCases, id: \.self) { mode in
                    chip(label: mode.label(forSaved: forSaved), isActive: filters.sort == mode) {
                        filters.sort = mode
                    }
                }
            }
        }
        .background(AppTheme.background(colorScheme))
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(AppTheme.border(colorScheme))
                .frame(height: 1)
        }
    }

    @ViewBuilder
    private func chipSection<Content: View>(label: String, @ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label.uppercased())
                .font(AppFont.sans(10, weight: .semibold))
                .tracking(0.6)
                .foregroundStyle(AppTheme.textLabel(colorScheme))
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 7)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    content()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            }
        }
    }

    @ViewBuilder
    private func chip(label: String, isActive: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(AppFont.sans(12, weight: .medium))
                .padding(.horizontal, 13)
                .padding(.vertical, 5)
                .foregroundStyle(isActive ? activeForeground : AppTheme.textMuted(colorScheme))
                .background(
                    Capsule().fill(isActive ? activeBackground : AppTheme.card(colorScheme))
                )
                .overlay(
                    Capsule().strokeBorder(isActive ? activeBorder : AppTheme.border(colorScheme), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    private var activeBackground: Color {
        colorScheme == .dark
            ? Color(red: 0.286, green: 0.278, blue: 0.263)        // mid-dark, matches PWA dark active
            : Color(red: 0.396, green: 0.353, blue: 0.290)        // oklch(42% 0.05 65)
    }
    private var activeForeground: Color {
        colorScheme == .dark
            ? Color(red: 0.92, green: 0.91, blue: 0.89)
            : .white
    }
    private var activeBorder: Color {
        colorScheme == .dark
            ? Color(red: 0.612, green: 0.601, blue: 0.585)
            : Color(red: 0.260, green: 0.225, blue: 0.180)
    }
}
