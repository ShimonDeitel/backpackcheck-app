import Foundation

struct ChecklistItem: Identifiable, Codable, Equatable {
    let id: UUID
    var childName: String
    var item: String
    var isDone: Bool
    var dateAdded: Date

    init(id: UUID = UUID(), childName: String = "", item: String = "", isDone: Bool = false, dateAdded: Date = Date()) {
        self.id = id
        self.childName = childName
        self.item = item
        self.isDone = isDone
        self.dateAdded = dateAdded
    }
}
