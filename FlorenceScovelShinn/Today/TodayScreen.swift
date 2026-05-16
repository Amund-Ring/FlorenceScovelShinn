import SwiftUI
import SwiftData

struct TodayScreen: View {
    @Environment(QuoteStore.self) private var store
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @Query private var userStates: [QuoteUserState]

    @AppStorage("todayStateJSON") private var todayStateJSON: String = ""
    @AppStorage("darkMode") private var darkModeOverride: String = "system"  // "system" | "light" | "dark"

    @State private var focusStartIndex: Int? = nil

    private var actions: UserStateActions {
        UserStateActions(context: context, userStates: userStates)
    }

    private var todayQuotes: [Quote] {
        currentState.slots.compactMap { store.quote(id: $0.id) }
    }

    var body: some View {
        VStack(spacing: 0) {
            header
            Divider()
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(Array(currentState.slots.enumerated()), id: \.offset) { idx, slot in
                        if let quote = store.quote(id: slot.id) {
                            Button {
                                focusStartIndex = idx
                            } label: {
                                slotCard(quote: quote, slot: slot, index: idx)
                            }
                            .buttonStyle(PressableCardStyle())
                        }
                    }

                    newSetButton
                        .padding(.top, 6)
                }
                .padding(.horizontal, 16)
                .padding(.top, 18)
                .padding(.bottom, 24)
            }
        }
        .background(AppTheme.background(colorScheme).ignoresSafeArea())
        .preferredColorScheme(preferredScheme)
        .onAppear(perform: bootstrap)
        .fullScreenCover(item: Binding(
            get: { focusStartIndex.map { FocusPresentation(startIndex: $0) } },
            set: { focusStartIndex = $0?.startIndex }
        )) { presentation in
            FocusMode(
                quotes: todayQuotes,
                idx: presentation.startIndex,
                isFavorite: { actions.isFavorite(quoteId: $0) },
                onToggleFavorite: { actions.toggleFavorite(quoteId: $0) }
            )
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Text("Today")
                .font(AppFont.serif(29))
                .foregroundStyle(.primary)
            Spacer()
            SquareIconButton(
                systemImage: colorScheme == .dark ? "sun.max" : "moon",
                size: 34
            ) {
                toggleDark()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 14)
    }

    // MARK: - Slot card

    @ViewBuilder
    private func slotCard(quote: Quote, slot: TodaySlot, index: Int) -> some View {
        let palette = CategoryColors.palette(for: quote.category)
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .fill(palette.accent)
                .frame(height: 4)
                .frame(maxWidth: .infinity)

            VStack(alignment: .leading, spacing: 11) {
                HStack(spacing: 6) {
                    Text(quote.category.rawValue)
                        .font(AppFont.sans(11.5, weight: .semibold))
                        .foregroundStyle(colorScheme == .dark ? palette.accent : palette.text)
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(
                            colorScheme == .dark
                                ? palette.accent.opacity(0.18)
                                : palette.background,
                            in: Capsule()
                        )
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
                        borderColor: slot.locked ? palette.accent : nil,
                        background: slot.locked
                            ? (colorScheme == .dark ? palette.accent.opacity(0.18) : palette.background)
                            : nil
                    ) {
                        var s = currentState
                        controller.toggleLock(&s, at: index)
                        save(s)
                    }
                }

                Text(quote.quote)
                    .font(AppFont.serif(16))
                    .lineSpacing(3)
                    .foregroundStyle(.primary)
                    .textSelection(.enabled)
                    .padding(.horizontal, 6)

                Text(quote.bookTitle)
                    .font(AppFont.sans(12.5))
                    .italic()
                    .foregroundStyle(.secondary)
                    .padding(.top, 2)
                    .padding(.horizontal, 6)
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 14)
        }
        .background(AppTheme.card(colorScheme))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppTheme.border(colorScheme), lineWidth: 1)
        )
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.05), radius: 4, x: 0, y: 1)
    }

    // MARK: - New Set button

    private var newSetButton: some View {
        Button {
            var s = currentState
            controller.refreshAll(&s)
            save(s)
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "arrow.clockwise")
                Text("New Set")
                    .font(AppFont.sans(14, weight: .medium))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                Capsule().fill(AppTheme.card(colorScheme))
            )
            .overlay(
                Capsule().stroke(AppTheme.border(colorScheme), lineWidth: 1.2)
            )
            .foregroundStyle(.primary)
        }
        .buttonStyle(.plain)
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

    // MARK: - Dark mode

    private var preferredScheme: ColorScheme? {
        switch darkModeOverride {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil
        }
    }

    private func toggleDark() {
        darkModeOverride = colorScheme == .dark ? "light" : "dark"
    }
}

private struct SquareIconButton: View {
    @Environment(\.colorScheme) private var colorScheme
    let systemImage: String
    var size: CGFloat = 30
    var tint: Color? = nil
    var borderColor: Color? = nil
    var background: Color? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: size * 0.43, weight: .medium))
                .foregroundStyle(tint ?? Color.secondary)
                .frame(width: size, height: size)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(background ?? AppTheme.card(colorScheme))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor ?? AppTheme.border(colorScheme), lineWidth: 1)
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
