import Foundation

enum QuoteCategory: String, Codable, CaseIterable, Hashable {
    case faith = "Faith"
    case abundance = "Abundance"
    case mindset = "Mindset"
    case love = "Love"
}

enum Book: String, Codable, CaseIterable, Hashable {
    case theGame = "The Game of Life and How to Play It"
    case yourWord = "Your Word Is Your Wand"
    case secretDoor = "The Secret Door to Success"
    case spokenWord = "The Power of the Spoken Word"

    var shortLabel: String {
        switch self {
        case .theGame: return "The Game"
        case .yourWord: return "Your Word"
        case .secretDoor: return "Secret Door"
        case .spokenWord: return "Spoken Word"
        }
    }
}
