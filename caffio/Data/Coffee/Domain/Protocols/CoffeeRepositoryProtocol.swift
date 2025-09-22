import SwiftUI

extension App.Coffee.Protocols {
    protocol Manageable {
        func getAllCoffees() async throws -> [App.Coffee.Entities.Model]
        func getCoffee(by id: UUID) async throws -> App.Coffee.Entities.Model?
        func saveCoffee(_ coffee: App.Coffee.Entities.Model) async throws
        func deleteCoffee(_ coffee: App.Coffee.Entities.Model) async throws
        func searchCoffees(query: String) async throws -> [App.Coffee.Entities.Model]
        func getCoffeesByDifficulty(_ difficulty: App.Coffee.Entities.Difficulty) async throws -> [App.Coffee.Entities.Model]
        func getCoffeesByType(_ type: App.Coffee.Entities.CoffeeType) async throws -> [App.Coffee.Entities.Model]
        func initializeDataIfNeeded() async throws
    }
}

