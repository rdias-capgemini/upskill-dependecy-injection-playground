import Foundation

public protocol TodoDbManaging {
    func getAll() throws -> [Todo]
}

public class TodoDbManager: TodoDbManaging {

    public init() { }

    public func getAll() throws -> [Todo] {
        // implement business logic, but for now returns a simple array
        return [
            Todo(title: "Water plants"),
            Todo(title: "Walk Fido")
        ]
    }
}

public class MockTodoDbManager: TodoDbManaging {

    public init() { }

    public func getAll() throws -> [Todo] {
        // For example, mock a situation where the
        // database fetch throws an error
        throw DatabaseError.getFailed
    }
}
