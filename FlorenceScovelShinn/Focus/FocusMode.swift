import SwiftUI

/// Full-screen swipeable quote viewer. Accessible from Today (3 slots)
/// and Saved (filtered favorites). Loops infinitely; tap dots / chevrons / swipe to navigate.
struct FocusMode: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss

    let quotes: [Quote]
    @State var idx: Int

    /// Lookup if a quote id is currently favorited. Recomputed every render
    /// so the heart icon stays in sync with SwiftData.
    var isFavorite: (String) -> Bool = { _ in false }
    var onToggleFavorite: (String) -> Void = { _ in }

    @State private var dragOffset: CGFloat = 0
    @State private var transitioning: Bool = false

    private var current: Quote { quotes[idx] }
    private var palette: CategoryPalette { CategoryColors.palette(for: current.category) }

    private var background: Color {
        colorScheme == .dark ? AppTheme.nightCard : palette.background
    }

    /// Match the PWA's scaling: longer quotes get smaller text.
    private var quoteFontSize: CGFloat {
        let len = current.quote.count
        if len > 220 { return 17.5 }
        if len > 150 { return 18.5 }
        if len > 100 { return 20.5 }
        return 21
    }

    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            VStack(spacing: 0) {
                topBar
                Spacer(minLength: 0)
                content
                Spacer(minLength: 0)
                bottomBar
            }
        }
        .animation(.easeInOut(duration: 0.30), value: current.id)
        .gesture(swipeGesture)
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack {
            iconButton(systemImage: "xmark") { dismiss() }
            Spacer()
            iconButton(
                systemImage: isFavorite(current.id) ? "heart.fill" : "heart",
                tint: isFavorite(current.id) ? heartAccent : nil,
                borderTint: isFavorite(current.id) ? heartAccent : nil,
                fillTint: isFavorite(current.id) ? heartAccent.opacity(colorScheme == .dark ? 0.14 : 0.10) : nil
            ) {
                onToggleFavorite(current.id)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    private var heartAccent: Color { Color(red: 0.78, green: 0.40, blue: 0.40) }

    // MARK: - Center content

    private var content: some View {
        VStack(spacing: 40) {
            Text(current.category.rawValue.uppercased())
                .font(AppFont.sans(15, weight: .semibold))
                .tracking(4)
                .foregroundStyle((colorScheme == .dark ? palette.accent : palette.text).opacity(0.6))

//            Text("\u{201C}\(current.quote)\u{201D}")
            Text(current.quote)
                .font(AppFont.serif(quoteFontSize))
                .lineSpacing(quoteFontSize * 0.45)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
//                .multilineTextAlignment(.leading)
            
//            Text("\(quoteFontSize, specifier: "%.1f")pt")
//                .font(.system(size: 11, weight: .medium).monospacedDigit())
//                .foregroundStyle(.secondary)

            VStack(spacing: 5) {
                Text(current.bookTitle)
                    .font(AppFont.sans(16))
                    .italic()
                    .foregroundStyle(.secondary)
                Text(current.chapterTitle)
                    .font(AppFont.sans(15.5))
                    .italic()
                    .foregroundStyle(AppTheme.textMuted(colorScheme))
            }

            if quotes.count > 1, quotes.count < 5 {
                pageDots
                    .padding(.top, 8)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 24)
        .opacity(transitioning ? 0 : 1)
        .offset(x: dragOffset * 0.4)
        .id(current.id)
        .transition(.opacity)
    }

    private var pageDots: some View {
        HStack(spacing: 8) {
            ForEach(quotes.indices, id: \.self) { i in
                Capsule()
                    .fill(i == idx ? Color.primary : AppTheme.border(colorScheme))
                    .frame(width: 36, height: 8)
                    .opacity(i == idx ? 1 : 0.5)
                    .contentShape(Capsule())
                    .onTapGesture { go(to: i) }
            }
        }
    }

    // MARK: - Bottom bar

    private var bottomBar: some View {
        HStack {
            iconButton(systemImage: "chevron.left", size: 40, isPrimary: true) { go(to: idx - 1) }
            Spacer()
            Text("\(idx + 1) / \(quotes.count)")
                .font(AppFont.sans(12, weight: .medium))
                .foregroundStyle(.secondary)
            Spacer()
            iconButton(systemImage: "chevron.right", size: 40, isPrimary: true) { go(to: idx + 1) }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 28)
    }

    // MARK: - Icon button

    @ViewBuilder
    private func iconButton(
        systemImage: String,
        size: CGFloat = 36,
        isPrimary: Bool = false,
        tint: Color? = nil,
        borderTint: Color? = nil,
        fillTint: Color? = nil,
        action: @escaping () -> Void
    ) -> some View {
        let radius: CGFloat = size > 36 ? 12 : 10
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: size * 0.4, weight: .medium))
                .foregroundStyle(tint ?? (isPrimary ? .primary : .secondary))
                .frame(width: size, height: size)
                .background(
                    RoundedRectangle(cornerRadius: radius)
                        .fill(fillTint ?? (colorScheme == .dark
                                           ? AppTheme.nightBg
                                           : Color.white.opacity(0.7)))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .strokeBorder(borderTint ?? AppTheme.border(colorScheme), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Navigation

    private func go(to newIdx: Int) {
        guard quotes.count > 1, !transitioning else { return }
        let n = quotes.count
        let wrapped = ((newIdx % n) + n) % n
        guard wrapped != idx else {
            withAnimation(.easeOut(duration: 0.15)) { dragOffset = 0 }
            return
        }
        transitioning = true
        withAnimation(.easeInOut(duration: 0.18)) {
            // Triggers content fade-out via `transitioning`.
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            idx = wrapped
            dragOffset = 0
            withAnimation(.easeInOut(duration: 0.18)) {
                transitioning = false
            }
        }
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 10)
            .onChanged { value in
                guard !transitioning else { return }
                dragOffset = value.translation.width
            }
            .onEnded { value in
                guard !transitioning else { return }
                if abs(value.translation.width) > 60 {
                    if value.translation.width < 0 {
                        go(to: idx + 1)
                    } else {
                        go(to: idx - 1)
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.15)) { dragOffset = 0 }
                }
            }
    }
}
