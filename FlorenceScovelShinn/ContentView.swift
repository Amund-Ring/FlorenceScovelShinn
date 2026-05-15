import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(QuoteStore.self) private var store
    @Query private var userStates: [QuoteUserState]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabeledContent("Total quotes", value: "\(store.quotes.count)")
                    LabeledContent("User state rows", value: "\(userStates.count)")
                }

                Section("First 5 quotes") {
                    ForEach(store.quotes.prefix(5)) { q in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(q.quote)
                                .font(.body)
                            HStack(spacing: 6) {
                                Text(q.category.rawValue)
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(CategoryColors.palette(for: q.category).text)
                                Text("·")
                                    .foregroundStyle(.secondary)
                                Text(q.book?.shortLabel ?? q.bookTitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                Section("Categories") {
                    ForEach(QuoteCategory.allCases, id: \.self) { cat in
                        let count = store.quotes.filter { $0.category == cat }.count
                        HStack {
                            Circle()
                                .fill(CategoryColors.palette(for: cat).accent)
                                .frame(width: 12, height: 12)
                            Text(cat.rawValue)
                            Spacer()
                            Text("\(count)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section("Books") {
                    ForEach(Book.allCases, id: \.self) { book in
                        let count = store.quotes.filter { $0.bookTitle == book.rawValue }.count
                        HStack {
                            Text(book.shortLabel)
                            Spacer()
                            Text("\(count)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("M1 — Foundation")
        }
    }
}

#Preview {
    ContentView()
        .environment(QuoteStore())
        .modelContainer(for: QuoteUserState.self, inMemory: true)
}
