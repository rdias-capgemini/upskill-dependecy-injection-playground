/*:
 [Previous](@previous)

 ## Example #2: Working with protocols

 We implement `TodoDbManaging` protocol, that defines a blueprint of
 functionality for managing a todo local database, and a class that
 conforms to it: `TodoDbManager`.

 */

import UIKit

protocol TodoDbManaging {
    func getAll() throws -> [Todo]
}

class TodoDbManager: TodoDbManaging {

    public func getAll() throws -> [Todo] {
        // implement business logic, but for now returns a simple array
        return [
            Todo(title: "Water plants"),
            Todo(title: "Walk Fido")
        ]
    }
}

/*:

 We revisit our `TodoService`, that declares a `dbManager` has its
 property (dependency), with type `TodoDbManaging`.

 */

class TodoService {
    var dbManager: TodoDbManaging?

    public func getAllTodosFromDatabase() -> [Todo]? {
        return try? dbManager?.getAll()
    }
}

// Initialize the service
let service = TodoService()

// Configure service with the desired database manager
service.dbManager = TodoDbManager()

// Retrieve all todos from database using the service
let todos = service.getAllTodosFromDatabase()
let todosCount = todos?.count

/*:

 The use of protocols allows for a greater decoupling of objects:
 * again, `TodoService` requires no knowledge of how its dependency is instantiated
 * allows to be assigned with values of different types, as long as those conform to `TodoDbManaging`

 This is very helpful, for example, in (unit) testing, using mock objects.

 */

class MockTodoDbManager: TodoDbManaging {

    public func getAll() throws -> [Todo] {
        // For example, mock a situation where the
        // database fetch throws an error
        throw DatabaseError.getFailed
    }
}

// Configure service with the desired database manager
service.dbManager = MockTodoDbManager()

// Retrieve all todos from database using the service
let mockTodos = service.getAllTodosFromDatabase()

//: [Next](@next)
