import SwiftUI

struct SavedScreen: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(title: "Saved")
            Divider()
            Spacer()
            VStack(spacing: 8) {
                Image(systemName: "star")
                    .font(.system(size: 32))
                    .foregroundStyle(.secondary)
                Text("No saved quotes yet")
                    .font(AppFont.sans(14))
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .background(AppTheme.background(colorScheme).ignoresSafeArea())
    }
}

#Preview {
    SavedScreen()
}
