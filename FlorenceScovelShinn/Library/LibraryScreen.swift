import SwiftUI

struct LibraryScreen: View {
    @Environment(QuoteStore.self) private var store
    @Environment(\.colorScheme) private var colorScheme

    @AppStorage("lib_category") private var category: String = "All"
    @AppStorage("lib_book")     private var book: String = "All"
    @AppStorage("lib_sort")     private var sortRaw: String = SortMode.date.rawValue

    @State private var search: String = ""
    @State private var showSearch: Bool = false
    @State private var showControls: Bool = false

    private var filters: Binding<LibraryFilters> {
        Binding(
            get: {
                LibraryFilters(
                    category: category,
                    book: book,
                    sort: SortMode(rawValue: sortRaw) ?? .date,
                    search: search
                )
            },
            set: { newValue in
                category = newValue.category
                book = newValue.book
                sortRaw = newValue.sort.rawValue
                search = newValue.search
            }
        )
    }

    private var filteredQuotes: [Quote] {
        applyFilters(store.quotes, filters: filters.wrappedValue, allQuotes: store.quotes)
    }

    private var groupedByCategory: [(QuoteCategory, [Quote])] {
        let groups = Dictionary(grouping: filteredQuotes, by: \.category)
        return groups
            .sorted { $0.key.rawValue < $1.key.rawValue }
            .map { ($0.key, $0.value) }
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            if showSearch {
                SearchBar(text: $search)
            }
            if showControls {
                FilterControls(filters: filters, forSaved: false)
            }
            ScrollView {
                LazyVStack(spacing: 0) {
                    if filters.wrappedValue.sort == .category {
                        ForEach(groupedByCategory, id: \.0) { cat, items in
                            CategorySectionHeader(category: cat)
                            ForEach(Array(items.enumerated()), id: \.element.id) { idx, quote in
                                LibraryRow(quote: quote, isLast: idx == items.count - 1)
                            }
                        }
                    } else {
                        ForEach(Array(filteredQuotes.enumerated()), id: \.element.id) { idx, quote in
                            LibraryRow(quote: quote, isLast: idx == filteredQuotes.count - 1)
                        }
                    }

                    if filteredQuotes.isEmpty {
                        emptyState
                    }
                }
                .padding(.leading, 18)
                .padding(.trailing, 16)
            }
        }
        .background(AppTheme.background(colorScheme).ignoresSafeArea())
    }

    private var header: some View {
        HStack {
            Text("Library")
                .font(AppFont.serif(28))
                .foregroundStyle(.primary)
            Spacer()
            HStack(spacing: 8) {
                HeaderToggle(systemImage: "magnifyingglass", isActive: showSearch || !search.isEmpty) {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        showSearch.toggle()
                        if !showSearch { search = "" }
                    }
                }
                HeaderToggle(systemImage: "slider.horizontal.3",
                             isActive: showControls || filters.wrappedValue.hasActiveFilters) {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        showControls.toggle()
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 14)
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 28))
                .foregroundStyle(.secondary)
            Text("No quotes match")
                .font(AppFont.sans(14))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}

/// Small section header used when sort = .category.
struct CategorySectionHeader: View {
    let category: QuoteCategory

    var body: some View {
        let palette = CategoryColors.palette(for: category)
        Text(category.rawValue.uppercased())
            .font(AppFont.sans(10, weight: .semibold))
            .tracking(0.7)
            .foregroundStyle(palette.text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 14)
            .padding(.bottom, 8)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .fill(palette.accent)
                    .frame(height: 2)
            }
            .padding(.bottom, 2)
    }
}

/// Toggle button used in the screen header for search / filter.
struct HeaderToggle: View {
    @Environment(\.colorScheme) private var colorScheme
    let systemImage: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(isActive ? activeForeground : AppTheme.textMuted(colorScheme))
                .frame(width: 34, height: 34)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isActive ? activeBackground : AppTheme.card(colorScheme))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isActive ? activeBorder : AppTheme.border(colorScheme), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    private var activeBackground: Color {
        colorScheme == .dark
            ? Color(red: 0.286, green: 0.278, blue: 0.263)
            : Color(red: 0.396, green: 0.353, blue: 0.290)
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

#Preview {
    LibraryScreen()
        .environment(QuoteStore())
}
