/*:
 [Previous](@previous)

 ## Forms of Dependency Injection
 ### Method injection (Setter)
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

    private var engine: EngineProtocol?

    func setEngine(engine: EngineProtocol) {
        self.engine = engine
    }

    func startEngine() {
        engine?.start()
    }
}

// Initialize the car object
let car = Car()

// Configure car with a V8 engine
car.setEngine(engine: EngineV8())

// Start car's engine
car.startEngine()

//: [Next](@next)
