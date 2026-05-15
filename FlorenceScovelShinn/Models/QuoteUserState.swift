import Foundation
import SwiftData

@Model
final class QuoteUserState {
    @Attribute(.unique) var quoteId: String
    var isFavorite: Bool
    var timesShown: Int
    var lastShown: Date?
    var dateAdded: Date?

    init(
        quoteId: String,
        isFavorite: Bool = false,
        timesShown: Int = 0,
        lastShown: Date? = nil,
        dateAdded: Date? = nil
    ) {
        self.quoteId = quoteId
        self.isFavorite = isFavorite
        self.timesShown = timesShown
        self.lastShown = lastShown
        self.dateAdded = dateAdded
    }
}
