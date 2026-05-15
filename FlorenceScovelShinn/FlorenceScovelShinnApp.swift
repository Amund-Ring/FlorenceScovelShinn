import SwiftUI
import SwiftData

@main
struct FlorenceScovelShinnApp: App {
    @State private var quoteStore = QuoteStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(quoteStore)
        }
        .modelContainer(for: QuoteUserState.self)
    }
}
