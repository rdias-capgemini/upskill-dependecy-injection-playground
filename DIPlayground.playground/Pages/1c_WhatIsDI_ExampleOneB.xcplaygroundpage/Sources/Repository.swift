import Foundation

// MARK: API related protocols/classess
public protocol ApiManaging: AnyObject {
    associatedtype T: Entity
}

public class ApiManager<T>: ApiManaging where T: Entity {
    public init() { }
}

// MARK: Database related protocols/classess
public protocol DbManaging: AnyObject {
    associatedtype T: Entity
}

public class DbManager<T>: DbManaging where T: Entity {
    public init() { }
}
