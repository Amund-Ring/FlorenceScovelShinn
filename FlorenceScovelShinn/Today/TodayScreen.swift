import SwiftUI
import SwiftData

struct TodayScreen: View {
    @Environment(QuoteStore.self) private var store
    @Environment(\.modelContext) private var context
    @Query private var userStates: [QuoteUserState]

    @AppStorage("todayStateJSON") private var todayStateJSON: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(currentState.slots.enumerated()), id: \.offset) { idx, slot in
                        if let quote = store.quote(id: slot.id) {
                            slotCard(quote: quote, slot: slot, index: idx)
                        }
                    }

                    Button {
                        var s = currentState
                        controller.refreshAll(&s)
                        save(s)
                    } label: {
                        Label("New Set", systemImage: "arrow.clockwise")
                            .font(.subheadline.weight(.medium))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.plain)
                    .background(
                        Capsule()
                            .stroke(Color(.separator), lineWidth: 1.2)
                            .background(Capsule().fill(Color(.secondarySystemBackground)))
                    )
                    .padding(.top, 8)
                }
                .padding(16)
            }
            .navigationTitle("Today")
            .onAppear(perform: bootstrap)
        }
    }

    // MARK: - Slot card (minimal styling — refined in M3)

    @ViewBuilder
    private func slotCard(quote: Quote, slot: TodaySlot, index: Int) -> some View {
        let palette = CategoryColors.palette(for: quote.category)
        VStack(alignment: .leading, spacing: 10) {
            Rectangle()
                .fill(palette.accent)
                .frame(height: 4)
                .frame(maxWidth: .infinity)

            HStack(spacing: 6) {
                Text(quote.category.rawValue)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(palette.text)
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(palette.background, in: Capsule())
                Spacer()
                if !slot.locked {
                    SquareIconButton(systemImage: "arrow.clockwise") {
                        var s = currentState
                        controller.refreshSlot(&s, at: index)
                        save(s)
                    }
                }
                SquareIconButton(
                    systemImage: slot.locked ? "lock.fill" : "lock.open",
                    tint: slot.locked ? palette.accent : nil,
                    borderColor: slot.locked ? palette.accent : nil
                ) {
                    var s = currentState
                    controller.toggleLock(&s, at: index)
                    save(s)
                }
            }
            .padding(.horizontal, 14)

            Text(quote.quote)
                .font(.body)
                .padding(.horizontal, 14)

            Text(quote.bookTitle)
                .font(.caption)
                .italic()
                .foregroundStyle(.secondary)
                .padding(.horizontal, 14)
                .padding(.bottom, 12)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - State plumbing

    private var controller: TodayController {
        TodayController(store: store, context: context, userStates: userStates)
    }

    private var currentState: TodayState {
        guard let data = todayStateJSON.data(using: .utf8),
              let decoded = try? JSONDecoder().decode(TodayState.self, from: data) else {
            return .empty
        }
        return decoded
    }

    private func save(_ state: TodayState) {
        guard let data = try? JSONEncoder().encode(state),
              let s = String(data: data, encoding: .utf8) else { return }
        todayStateJSON = s
    }

    private func bootstrap() {
        var s = currentState
        guard s.isEmpty else { return }
        controller.bootstrapIfNeeded(&s)
        save(s)
    }
}

private struct SquareIconButton: View {
    let systemImage: String
    var tint: Color? = nil
    var borderColor: Color? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(tint ?? Color.secondary)
                .frame(width: 30, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor ?? Color(.separator), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TodayScreen()
        .environment(QuoteStore())
        .modelContainer(for: QuoteUserState.self)
}
