/*:
 [Previous](@previous)

 ## Forms of Dependency Injection
 ### Property injection
 */

import Foundation

protocol EngineProtocol {
    var isRunning: Bool { get set }
    func start()
    func stop()
}

class EngineV8: EngineProtocol {

    var isRunning: Bool = false

    func start() {
        print("Started the V8 engine!")
        self.isRunning = true
    }

    func stop() {
        print("Stopped the V8 engine...")
        self.isRunning = false
    }
}

class Car {
    public var engine: EngineProtocol?

    func startEngine() {
        engine?.start()
    }
}

// Initialize the car object
let car = Car()

// Configure car with a V8 engine
car.engine = EngineV8()

// Start car's engine
car.startEngine()

//: [Next](@next)
