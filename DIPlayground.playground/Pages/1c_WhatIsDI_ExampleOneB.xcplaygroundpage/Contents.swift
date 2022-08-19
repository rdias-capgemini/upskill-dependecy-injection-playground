/*:
 [Previous](@previous)

 ## Example #1b: With dependency injection

 We inject the desired instance into `TodoListViewController
 * allows for greater decoupling of objects within the application

 */

import UIKit

class TodoListViewController: UITableViewController {

    var todoService: TodoService?
}

// Initialize view controller
let viewController = TodoListViewController()

// Configure view controller
viewController.todoService = TodoService()

// If it was the case, we could even configure
// the service to address its own dependencies
viewController.todoService = TodoService(
    api: ApiManager<TodoObj>(),
    database: DbManager<Todo>()
)

//: [Next](@next)
