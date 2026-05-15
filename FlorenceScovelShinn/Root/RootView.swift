import SwiftUI

struct RootView: View {
    @AppStorage("activeTab") private var activeTab: String = "today"
    @AppStorage("darkMode") private var darkModeOverride: String = "system"

    var body: some View {
        TabView(selection: $activeTab) {
            TodayScreen()
                .tag("today")
                .tabItem { Label("Today", systemImage: "sun.max") }

            LibraryScreen()
                .tag("library")
                .tabItem { Label("Library", systemImage: "book") }

            SavedScreen()
                .tag("saved")
                .tabItem { Label("Saved", systemImage: activeTab == "saved" ? "star.fill" : "star") }
        }
        .preferredColorScheme(preferredScheme)
        .tint(.primary)
    }

    private var preferredScheme: ColorScheme? {
        switch darkModeOverride {
        case "light": return .light
        case "dark":  return .dark
        default:      return nil
        }
    }
}

#Preview {
    RootView()
        .environment(QuoteStore())
}
