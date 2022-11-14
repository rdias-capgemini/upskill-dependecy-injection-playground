import Foundation

// MARK: Entities (Model)
public protocol Entity: Codable { }
public struct Todo: Entity {
    var title: String

    public init(title: String) {
        self.title = title
    }
}
