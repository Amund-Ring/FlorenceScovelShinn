import SwiftUI

/// Simple header row used by screens that don't have their own custom one (e.g. Saved).
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
