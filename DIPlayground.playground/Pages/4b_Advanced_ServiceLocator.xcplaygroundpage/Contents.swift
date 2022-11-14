/*:
 [Previous](@previous)

 ## Advanced topics
 ### Service Locator
 */


import Foundation

// MARK: Resolver

protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T
}

// MARK: Container

class Container: Resolver {

    // definition of the generic `Factory` typealias
    typealias Factory = (Resolver) -> Any

    // storage for all the ”factory-created”
    // instances of registered types
    var factories = [String: Factory]()

    // MARK: Container > Register methods

    // registering a certain instances of a class
    // without providing a factory
    func register<T>(
        _ type: T.Type,
        instance: T
    ) -> Container {
        return register(type) { _ in instance }
    }

    // method for registering factories for a certain type
    func register<T>(
        _ type: T.Type,
        factory: @escaping (Resolver) -> T
    ) -> Container {

        // generates the dictionary key to identify
        // the factory to be registered
        let key = String(reflecting: type)

        // Stores the "instance-creating" factory
        print("Registering new instance of \(key).")
        factories[key] = factory

        return self
    }

    // MARK: Resolver methods

    // method for resolving the actual
    // implementation of the requested type
    func resolve<T>(
        _ type: T.Type
    ) -> T {
        // generates the dictionary key to
        // identify the factory to be resolved
        let key = String(reflecting: type)

        // searches container storage for the
        // actual implemenetation of requested type
        if let factory = factories[key],
           let instance = factory(self) as? T {

            // returns an instance of requested type
            print("Resolving new instance of \(T.self).")
            return instance
        }

        // returns a fatal error if type was never registered
        fatalError("\(key) has not been registered.")
    }
}

// create a container registry
let todoContainer = Container()
    .register(UserDefaults.self, instance: UserDefaults.standard)
    .register(TodoDbManaging.self) { _ in TodoDbManager() }
    .register(TodoService.self) { resolver in
        let manager = resolver.resolve(TodoDbManaging.self)
        return TodoService(database: manager)
    }
    .register(TodoListViewController.self) { resolver in
        let service = resolver.resolve(TodoService.self)
        let controller = TodoListViewController()
        controller.todoService = service
        return controller
    }

// resolving dependencies
let todoVC = todoContainer.resolve(TodoListViewController.self)
let todos = todoVC.todoService?.getAllTodosFromDatabase()
print("\nTodos:")
todos?.forEach { print($0) }
print("-\n")

// create a container registry with mocked dependencies
let otherContainer = Container()
  .register(TodoDbManaging.self) { _ in MockTodoDbManager() }

// resolving dependencies
let mockedDbManager = otherContainer.resolve(TodoDbManaging.self)
let mockedTodos = try? mockedDbManager.getAll()
print("\nMocked Todos:")
mockedTodos?.forEach { print($0) }
print("-\n")

//: [Next](@next)
