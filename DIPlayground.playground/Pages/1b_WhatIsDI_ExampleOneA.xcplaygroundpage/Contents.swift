/*:
 [Previous](@previous)

 ## Example #1a: Without dependency injection

 We task the `TodoListViewController` class with the instantiation of the `TodoService` instance
 * it knows about the behaviour of the `TodoService` class
 * **it also knows and is responsible for its instantiation**

 */

import UIKit

class TodoListViewController: UITableViewController {

    var todoService: TodoService? = TodoService()
}

//: [Next](@next)
