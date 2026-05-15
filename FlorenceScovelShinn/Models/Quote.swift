import Foundation

struct Quote: Codable, Identifiable, Hashable {
    let id: String
    let quote: String
    let bookTitle: String
    let chapterTitle: String
    let category: QuoteCategory

    enum CodingKeys: String, CodingKey {
        case id
        case quote
        case bookTitle = "book_title"
        case chapterTitle = "chapter_title"
        case category
    }

    var book: Book? { Book(rawValue: bookTitle) }
}

struct QuotesFile: Codable {
    let quotes: [Quote]
}
