import Foundation

/// Wrapper so we can use `.fullScreenCover(item:)` with an Int start index
/// (Int alone isn't Identifiable). Identity is derived from the start index
/// so the sheet doesn't tear down and re-present every time the parent
/// re-renders (e.g. when SwiftData notifies of a favorite change).
struct FocusPresentation: Identifiable {
    let startIndex: Int
    var id: Int { startIndex }
}
