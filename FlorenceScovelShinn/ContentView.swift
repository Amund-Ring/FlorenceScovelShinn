import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TodayScreen()
    }
}

#Preview {
    ContentView()
        .environment(QuoteStore())
        .modelContainer(for: QuoteUserState.self)
}
