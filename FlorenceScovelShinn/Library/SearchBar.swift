import SwiftUI

struct SearchBar: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textMuted(colorScheme))

            TextField("Search quotes…", text: $text)
                .font(AppFont.sans(15))
                .foregroundStyle(.primary)
                .focused($isFocused)
                .submitLabel(.search)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                    isFocused = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(AppTheme.textMuted(colorScheme))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(searchBg)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(AppTheme.border(colorScheme))
                .frame(height: 1)
        }
        .onAppear { isFocused = true }
    }

    private var searchBg: Color {
        colorScheme == .dark
            ? Color(red: 0.286, green: 0.278, blue: 0.263)   // oklch(28% 0.015 60)
            : Color(red: 0.937, green: 0.929, blue: 0.914)   // oklch(94% 0.008 60)
    }
}
