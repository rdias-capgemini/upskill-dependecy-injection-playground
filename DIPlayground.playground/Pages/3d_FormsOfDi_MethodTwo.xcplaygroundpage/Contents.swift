/*:
 [Previous](@previous)

 ## Forms of Dependency Injection
 ### Method injection (without property)
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

    var isEngineRunning: Bool = false

    func startEngine(with engine: EngineProtocol) {
        engine.start()
        isEngineRunning = engine.isRunning
    }
}

// Initialize the car object
let car = Car()

// Start car's engine, injected as a method argument
car.startEngine(with: EngineV8())

//: [Next](@next)
