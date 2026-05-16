import SwiftUI

/// A button style that gives the wrapped view a subtle scale-down on press,
/// creating tactile feedback for tappable cards and rows.
struct PressableCardStyle: ButtonStyle {
    var pressedScale: CGFloat = 0.98

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? pressedScale : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
