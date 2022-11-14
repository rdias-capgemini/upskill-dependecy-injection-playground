import Foundation

public class TodoService {

    var dbManager: TodoDbManaging?

    public init(database: TodoDbManaging) {
        self.dbManager = database
    }

    public func getAllTodosFromDatabase() -> [Todo]? {
        return try? dbManager?.getAll()
    }
}
