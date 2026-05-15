import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        RootView()
    }
}

#Preview {
    ContentView()
        .environment(QuoteStore())
        .modelContainer(for: QuoteUserState.self)
}
