import Foundation
import SwiftData

/// Helpers that mutate per-quote user state through SwiftData.
/// Centralised so Library, Saved, and any future screen share the same logic.
@MainActor
struct UserStateActions {
    let context: ModelContext
    let userStates: [QuoteUserState]

    private func findOrCreate(quoteId: String) -> QuoteUserState {
        if let existing = userStates.first(where: { $0.quoteId == quoteId }) {
            return existing
        }
        let new = QuoteUserState(quoteId: quoteId)
        context.insert(new)
        return new
    }

    func toggleFavorite(quoteId: String) {
        let state = findOrCreate(quoteId: quoteId)
        state.isFavorite.toggle()
        if state.isFavorite, state.dateAdded == nil {
            state.dateAdded = Date()
        }
        try? context.save()
    }

    func isFavorite(quoteId: String) -> Bool {
        userStates.first(where: { $0.quoteId == quoteId })?.isFavorite ?? false
    }

    func dateAdded(quoteId: String) -> Date? {
        userStates.first(where: { $0.quoteId == quoteId })?.dateAdded
    }
}
