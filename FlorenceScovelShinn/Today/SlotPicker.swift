import SwiftUI
import SwiftData

/// Bottom sheet shown when the user taps "+" on a Library/Saved row.
/// Lets them choose which of the 3 Today slots to replace with the incoming quote.
struct SlotPicker: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(QuoteStore.self) private var store
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var userStates: [QuoteUserState]

    @AppStorage("todayStateJSON") private var todayStateJSON: String = ""

    let incomingQuote: Quote

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            grabber
            preview
            slotsList
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 24)
        .background(AppTheme.background(colorScheme))
        .presentationDetents([.fraction(0.55), .medium])
        .presentationDragIndicator(.hidden)
    }

    private var grabber: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(AppTheme.border(colorScheme))
            .frame(width: 36, height: 4)
            .frame(maxWidth: .infinity)
    }

    private var preview: some View {
        let palette = CategoryColors.palette(for: incomingQuote.category)
        return VStack(alignment: .leading, spacing: 8) {
            Text("Add to Today")
                .font(AppFont.serif(20))
                .foregroundStyle(.primary)
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .fill(palette.accent)
                    .frame(width: 3)
                VStack(alignment: .leading, spacing: 6) {
                    CategoryPill(category: incomingQuote.category)
                    Text(truncated(incomingQuote.quote, max: 110))
                        .font(AppFont.serif(14))
                        .lineSpacing(2)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
            }
            .background(
                colorScheme == .dark
                    ? palette.accent.opacity(0.10)
                    : palette.background
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    private var slotsList: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("CHOOSE A SLOT TO REPLACE")
                .font(AppFont.sans(10, weight: .semibold))
                .tracking(0.6)
                .foregroundStyle(AppTheme.textLabel(colorScheme))
                .padding(.bottom, 2)

            ForEach(Array(currentSlots.enumerated()), id: \.offset) { idx, slot in
                slotRow(index: idx, slot: slot)
            }
        }
    }

    private func slotRow(index: Int, slot: TodaySlot) -> some View {
        let quote = store.quote(id: slot.id)
        let palette = quote.map { CategoryColors.palette(for: $0.category) }
        return Button {
            guard !slot.locked else { return }
            assign(to: index)
            dismiss()
        } label: {
            HStack(spacing: 12) {
                Text("Slot \(index + 1)")
                    .font(AppFont.sans(11, weight: .semibold))
                    .foregroundStyle(AppTheme.textLabel(colorScheme))
                    .frame(width: 48, alignment: .leading)

                VStack(alignment: .leading, spacing: 4) {
                    if let quote {
                        Text(quote.quote)
                            .font(AppFont.serif(13))
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        if let palette {
                            Text(quote.category.rawValue.uppercased())
                                .font(AppFont.sans(9, weight: .semibold))
                                .tracking(0.4)
                                .foregroundStyle(palette.accent)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if slot.locked {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(AppTheme.textMuted(colorScheme))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(AppTheme.textMuted(colorScheme))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(slot.locked ? AppTheme.background(colorScheme) : AppTheme.card(colorScheme))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(AppTheme.border(colorScheme), lineWidth: 1)
            )
            .opacity(slot.locked ? 0.55 : 1)
        }
        .buttonStyle(.plain)
        .disabled(slot.locked)
    }

    // MARK: - State

    private var currentSlots: [TodaySlot] {
        guard let data = todayStateJSON.data(using: .utf8),
              let decoded = try? JSONDecoder().decode(TodayState.self, from: data) else {
            return []
        }
        return decoded.slots
    }

    private func assign(to index: Int) {
        guard let data = todayStateJSON.data(using: .utf8),
              var state = try? JSONDecoder().decode(TodayState.self, from: data) else { return }
        guard state.slots.indices.contains(index) else { return }
        state.slots[index].id = incomingQuote.id

        // Track usage
        let actions = UserStateActions(context: context, userStates: userStates)
        let _ = actions  // (kept for symmetry; recordShown handled inline below)
        if let existing = userStates.first(where: { $0.quoteId == incomingQuote.id }) {
            existing.timesShown += 1
            existing.lastShown = Date()
        } else {
            let new = QuoteUserState(quoteId: incomingQuote.id, timesShown: 1, lastShown: Date())
            context.insert(new)
        }
        try? context.save()

        if let encoded = try? JSONEncoder().encode(state),
           let s = String(data: encoded, encoding: .utf8) {
            todayStateJSON = s
        }
    }

    private func truncated(_ s: String, max: Int) -> String {
        s.count > max ? String(s.prefix(max)).trimmingCharacters(in: .whitespaces) + "…" : s
    }
}
