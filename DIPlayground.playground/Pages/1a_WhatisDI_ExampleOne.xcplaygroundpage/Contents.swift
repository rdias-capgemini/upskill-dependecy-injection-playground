/*:
 [Previous](@previous)

 ## Example #1

 * `TodoListViewController`, a subclass of `UITableViewController` that displays a list of user’s to-dos.\
 Declares a property `todoService`, of type `TodoService?`.
 * `todoService` is responsible for handling all our business logic for this screen.\
 (retrieving a list of to-dos from a remote database, maintaining a local version, etc)

 */

import UIKit

class TodoListViewController: UITableViewController {

    var todoService: TodoService?
}

//: [Next](@next)
