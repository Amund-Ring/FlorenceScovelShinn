import Foundation

@Observable
final class QuoteStore {
    let quotes: [Quote]
    private let byId: [String: Quote]

    init() {
        self.quotes = Self.loadQuotes()
        self.byId = Dictionary(uniqueKeysWithValues: quotes.map { ($0.id, $0) })
    }

    func quote(id: String) -> Quote? { byId[id] }

    private static func loadQuotes() -> [Quote] {
        guard let url = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
            assertionFailure("quotes.json missing from bundle")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(QuotesFile.self, from: data).quotes
        } catch {
            assertionFailure("Failed to decode quotes.json: \(error)")
            return []
        }
    }

    /// Weighted random pick. Quotes shown less often are more likely;
    /// quotes already shown today are heavily penalised.
    /// `usage` maps quoteId -> (timesShown, lastShown).
    func pickQuote(
        excluding excludeIds: Set<String>,
        usage: [String: (timesShown: Int, lastShown: Date?)]
    ) -> Quote? {
        let pool = quotes.filter { !excludeIds.contains($0.id) }
        guard !pool.isEmpty else { return quotes.first { !excludeIds.contains($0.id) } ?? quotes.first }

        let calendar = Calendar.current
        let today = Date()
        let weights: [Double] = pool.map { q in
            let u = usage[q.id]
            var w = 1.0 / Double((u?.timesShown ?? 0) + 1)
            if let last = u?.lastShown, calendar.isDate(last, inSameDayAs: today) {
                w *= 0.1
            }
            return w
        }
        let total = weights.reduce(0, +)
        guard total > 0 else { return pool.randomElement() }
        var r = Double.random(in: 0..<total)
        for (i, w) in weights.enumerated() {
            r -= w
            if r <= 0 { return pool[i] }
        }
        return pool.last
    }
}
