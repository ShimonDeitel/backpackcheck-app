import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published private(set) var items: [ChecklistItem] = []
    @Published var isPro: Bool = false

    static let freeLimit = 200

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("backpackcheck_items.json")
        load()
    }

    var isAtFreeLimit: Bool {
        !isPro && items.count >= Store.freeLimit
    }

    func add(_ item: ChecklistItem) -> Bool {
        guard !isAtFreeLimit else { return false }
        items.insert(item, at: 0)
        save()
        return true
    }

    func update(_ item: ChecklistItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: ChecklistItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([ChecklistItem].self, from: data) else {
            items = [
        ChecklistItem(childName: "Sample Childname 1", item: "Sample Item 1", isDone: false, dateAdded: Calendar.current.date(byAdding: .day, value: -0, to: Date()) ?? Date()),
        ChecklistItem(childName: "Sample Childname 2", item: "Sample Item 2", isDone: true, dateAdded: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()),
        ChecklistItem(childName: "Sample Childname 3", item: "Sample Item 3", isDone: false, dateAdded: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date())
            ]
            save()
            return
        }
        items = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}
