/*:
 [Previous](@previous)

 ## Advanced topics
 ### Factory
 */

import UIKit

// MARK: Todo View Controller
class TodoListViewController: UITableViewController {

    var todoService: TodoService?
}

// MARK: Todo Service
class TodoService {

    var dbManager: TodoDbManaging?

    public init(database: TodoDbManaging) {
        self.dbManager = database
    }

    public func getAllTodosFromDatabase() -> [Todo]? {
        return try? dbManager?.getAll()
    }
}


// MARK: Todo Factory
protocol TodoFactory {

  func makeTodoService() -> TodoService
  func makeTodoListViewController() -> TodoListViewController
}

class DefaultTodoFactory: TodoFactory {

    // Public/protocol methods
  func makeTodoService() -> TodoService {
    let dbManager = makeTodoDbManager()
    return TodoService(database: dbManager)
  }

  func makeTodoListViewController() -> TodoListViewController {
    let todoListViewController = TodoListViewController()
    todoListViewController.todoService = makeTodoService()
    return todoListViewController
  }

  // Private factory methods
  private func makeTodoDbManager() -> TodoDbManaging {
        // if `TodoDbManager` itself had its own dependencies we could
        // easily add other (private) factory methods to create them.
    return TodoDbManager()
  }
}

// Initialize the default todo factory (if not available already)
let factory = DefaultTodoFactory()

// Initialize view controller
// (configured of all required levels of dependencies)
let todoListVC = factory.makeTodoListViewController()

//: [Next](@next)
