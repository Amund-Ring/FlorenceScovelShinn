import SwiftUI
import SwiftData

struct SavedScreen: View {
    @Environment(QuoteStore.self) private var store
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @Query private var userStates: [QuoteUserState]

    @AppStorage("saved_category") private var category: String = "All"
    @AppStorage("saved_book")     private var book: String = "All"
    @AppStorage("saved_sort")     private var sortRaw: String = SortMode.date.rawValue

    @State private var search: String = ""
    @State private var showSearch: Bool = false
    @State private var showControls: Bool = false
    @State private var slotPickerQuote: Quote? = nil
    @State private var focusStartIndex: Int? = nil

    private var actions: UserStateActions {
        UserStateActions(context: context, userStates: userStates)
    }

    private var favoriteIds: Set<String> {
        Set(userStates.filter(\.isFavorite).map(\.quoteId))
    }

    private var favoriteQuotes: [Quote] {
        store.quotes.filter { favoriteIds.contains($0.id) }
    }

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
        applyFilters(
            favoriteQuotes,
            filters: filters.wrappedValue,
            allQuotes: store.quotes,
            dateAddedLookup: { actions.dateAdded(quoteId: $0.id) }
        )
    }

    private var groupedByCategory: [(QuoteCategory, [Quote])] {
        Dictionary(grouping: filteredQuotes, by: \.category)
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
                FilterControls(filters: filters, forSaved: true)
            }
            ScrollView {
                LazyVStack(spacing: 0) {
                    if favoriteQuotes.isEmpty {
                        emptyState
                    } else if filteredQuotes.isEmpty {
                        noMatchState
                    } else if filters.wrappedValue.sort == .category {
                        ForEach(groupedByCategory, id: \.0) { cat, items in
                            CategorySectionHeader(category: cat)
                            ForEach(Array(items.enumerated()), id: \.element.id) { idx, quote in
                                row(for: quote, isLast: idx == items.count - 1)
                            }
                        }
                    } else {
                        ForEach(Array(filteredQuotes.enumerated()), id: \.element.id) { idx, quote in
                            row(for: quote, isLast: idx == filteredQuotes.count - 1)
                        }
                    }
                }
                .padding(.leading, 18)
                .padding(.trailing, 16)
            }
        }
        .background(AppTheme.background(colorScheme).ignoresSafeArea())
        .sheet(item: $slotPickerQuote) { quote in
            SlotPicker(incomingQuote: quote)
        }
        .fullScreenCover(item: Binding(
            get: { focusStartIndex.map { FocusPresentation(startIndex: $0) } },
            set: { focusStartIndex = $0?.startIndex }
        )) { presentation in
            FocusMode(
                quotes: filteredQuotes,
                idx: presentation.startIndex,
                isFavorite: { actions.isFavorite(quoteId: $0) },
                onToggleFavorite: { actions.toggleFavorite(quoteId: $0) }
            )
        }
    }

    @ViewBuilder
    private func row(for quote: Quote, isLast: Bool) -> some View {
        LibraryRow(
            quote: quote,
            isFavorite: true,
            isLast: isLast,
            onTap: {
                if let idx = filteredQuotes.firstIndex(where: { $0.id == quote.id }) {
                    focusStartIndex = idx
                }
            },
            onFavorite: { actions.toggleFavorite(quoteId: quote.id) },
            onAddToToday: { slotPickerQuote = quote }
        )
    }

    private var header: some View {
        HStack {
            Text("Saved")
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
            Image(systemName: "star")
                .font(.system(size: 32))
                .foregroundStyle(.secondary)
            Text("No saved quotes yet")
                .font(AppFont.sans(14))
                .foregroundStyle(.secondary)
            Text("Tap the heart on any quote to save it here.")
                .font(AppFont.sans(12))
                .foregroundStyle(AppTheme.textMuted(colorScheme))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
    }

    private var noMatchState: some View {
        VStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 28))
                .foregroundStyle(.secondary)
            Text("No saved quotes match")
                .font(AppFont.sans(14))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}

#Preview {
    SavedScreen()
        .environment(QuoteStore())
        .modelContainer(for: QuoteUserState.self)
}
