import Foundation
import SwiftData
import SwiftUI

/// Owns Today-slot logic. Persists slots as JSON in @AppStorage and
/// reads/writes per-quote usage (timesShown, lastShown) through SwiftData.
@MainActor
struct TodayController {
    let store: QuoteStore
    let context: ModelContext
    let userStates: [QuoteUserState]

    /// Build usage map for the weighted picker.
    private var usage: [String: (timesShown: Int, lastShown: Date?)] {
        Dictionary(uniqueKeysWithValues: userStates.map {
            ($0.quoteId, ($0.timesShown, $0.lastShown))
        })
    }

    private func userState(for quoteId: String) -> QuoteUserState {
        if let existing = userStates.first(where: { $0.quoteId == quoteId }) {
            return existing
        }
        let new = QuoteUserState(quoteId: quoteId)
        context.insert(new)
        return new
    }

    private func recordShown(_ quoteId: String) {
        let state = userState(for: quoteId)
        state.timesShown += 1
        state.lastShown = Date()
    }

    /// Initial pick of 3 quotes if state is empty.
    func bootstrapIfNeeded(_ state: inout TodayState) {
        guard state.slots.isEmpty else { return }
        var picked: Set<String> = []
        var slots: [TodaySlot] = []
        for _ in 0..<3 {
            guard let q = store.pickQuote(excluding: picked, usage: usage) else { break }
            picked.insert(q.id)
            slots.append(TodaySlot(id: q.id, locked: false))
            recordShown(q.id)
        }
        state.slots = slots
        try? context.save()
    }

    func toggleLock(_ state: inout TodayState, at index: Int) {
        guard state.slots.indices.contains(index) else { return }
        state.slots[index].locked.toggle()
    }

    func refreshSlot(_ state: inout TodayState, at index: Int) {
        guard state.slots.indices.contains(index) else { return }
        let exclude = Set(state.slots.enumerated().compactMap { $0.offset == index ? nil : $0.element.id })
        guard let q = store.pickQuote(excluding: exclude, usage: usage) else { return }
        state.slots[index].id = q.id
        recordShown(q.id)
        try? context.save()
    }

    func refreshAll(_ state: inout TodayState) {
        let lockedIds = Set(state.slots.filter(\.locked).map(\.id))
        var alreadyPicked: Set<String> = []
        for i in state.slots.indices where !state.slots[i].locked {
            let exclude = lockedIds.union(alreadyPicked)
            guard let q = store.pickQuote(excluding: exclude, usage: usage) else { continue }
            state.slots[i].id = q.id
            alreadyPicked.insert(q.id)
            recordShown(q.id)
        }
        try? context.save()
    }
}
