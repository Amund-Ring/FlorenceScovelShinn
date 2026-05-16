import Foundation

enum SortMode: String, CaseIterable {
    case date   // "Order in Book" (Library default) / "Date Added" (Saved default)
    case alpha
    case category

    func label(forSaved: Bool) -> String {
        switch self {
        case .date:     return forSaved ? "Date Added" : "Order in Book"
        case .alpha:    return "A–Z"
        case .category: return "By Category"
        }
    }
}

struct LibraryFilters {
    var category: String = "All"   // "All" or QuoteCategory.rawValue
    var book: String = "All"       // "All" or Book.rawValue (full title)
    var sort: SortMode = .date
    var search: String = ""

    var hasActiveFilters: Bool {
        category != "All" || book != "All" || sort != .date
    }
}

/// Apply category/book/search/sort to a list of quotes.
/// - `allQuotes` is used as the canonical order for `.date` sort in Library.
/// - When `dateAddedLookup` is provided (Saved screen), `.date` sort uses
///   most-recently-added first instead of book order.
func applyFilters(
    _ quotes: [Quote],
    filters: LibraryFilters,
    allQuotes: [Quote],
    dateAddedLookup: ((Quote) -> Date?)? = nil
) -> [Quote] {
    var result = quotes

    if filters.category != "All" {
        result = result.filter { $0.category.rawValue == filters.category }
    }
    if filters.book != "All" {
        result = result.filter { $0.bookTitle == filters.book }
    }
    let trimmedSearch = filters.search.trimmingCharacters(in: .whitespaces)
    if !trimmedSearch.isEmpty {
        let needle = trimmedSearch.lowercased()
        result = result.filter { $0.quote.lowercased().contains(needle) }
    }

    switch filters.sort {
    case .alpha:
        result.sort { $0.quote.localizedCaseInsensitiveCompare($1.quote) == .orderedAscending }
    case .date:
        if let dateAddedLookup {
            result.sort { (dateAddedLookup($0) ?? .distantPast) > (dateAddedLookup($1) ?? .distantPast) }
        } else {
            let order = Dictionary(uniqueKeysWithValues: allQuotes.enumerated().map { ($1.id, $0) })
            result.sort { (order[$0.id] ?? 0) < (order[$1.id] ?? 0) }
        }
    case .category:
        result.sort { a, b in
            if a.category != b.category {
                return a.category.rawValue < b.category.rawValue
            }
            return a.quote.localizedCaseInsensitiveCompare(b.quote) == .orderedAscending
        }
    }

    return result
}
