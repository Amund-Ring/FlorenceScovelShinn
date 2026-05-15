import SwiftUI

struct LibraryScreen: View {
    @Environment(QuoteStore.self) private var store
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(title: "Library")
            Divider()
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(Array(store.quotes.enumerated()), id: \.element.id) { idx, quote in
                        LibraryRow(
                            quote: quote,
                            isLast: idx == store.quotes.count - 1
                        )
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 13)
            }
        }
        
        .background(AppTheme.background(colorScheme).ignoresSafeArea())
    }
}

struct ScreenHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(AppFont.serif(28))
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 14)
    }
}

#Preview {
    LibraryScreen()
        .environment(QuoteStore())
}
