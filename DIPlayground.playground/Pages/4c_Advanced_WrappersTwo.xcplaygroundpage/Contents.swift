/*:
 [Previous](@previous)

 ## Advanced topics
 ### Property Wrappers (Container/Locator as passed dependency)
 */

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

// MARK: Property wrapper

@propertyWrapper
struct Injected<T> {

    let wrappedValue: T

    init(container: Container) {
        // resolves the property wrapper with
        // the provided container configuration
        wrappedValue = container.resolve(T.self)
    }
}

public class TodoService {

    // declare our property to be injected
    // (using `Injected` property wrapper)
    @Injected(container: container)
    var dbManager: TodoDbManaging

    // method to retrieve all todos from
    // (injected) database
    public func getAllTodosFromDatabase() -> [Todo]? {
        return try? dbManager.getAll()
    }
}

// create a container registry
let container = Container().register(TodoDbManaging.self) { _ in TodoDbManager() }

// resolving dependencies
let todoService = TodoService()
let todos = todoService.getAllTodosFromDatabase()
print("\nTodos:")
todos?.forEach { print($0) }
print("-\n")

//: [Next](@next)
