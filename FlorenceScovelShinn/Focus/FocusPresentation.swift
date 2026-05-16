import Foundation

/// Wrapper so we can use `.fullScreenCover(item:)` with an Int start index
/// (Int alone isn't Identifiable).
struct FocusPresentation: Identifiable {
    let id = UUID()
    let startIndex: Int
}
