import Foundation

struct TodaySlot: Codable, Hashable {
    var id: String
    var locked: Bool
}

struct TodayState: Codable, Hashable {
    var slots: [TodaySlot]

    static let empty = TodayState(slots: [])
    var isEmpty: Bool { slots.isEmpty }
}
