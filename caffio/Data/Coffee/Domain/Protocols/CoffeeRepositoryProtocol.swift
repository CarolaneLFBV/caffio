import SwiftUI

extension App.Coffee.Protocols {
    protocol Manageable {
        func getAllCoffees() async throws -> [App.Coffee.Entities.Coffee]
        func getCoffee(by id: UUID) async throws -> App.Coffee.Entities.Coffee?
        func saveCoffee(_ coffee: App.Coffee.Entities.Coffee) async throws
        func deleteCoffee(_ coffee: App.Coffee.Entities.Coffee) async throws
        func searchCoffees(query: String) async throws -> [App.Coffee.Entities.Coffee]
        func getCoffeesByDifficulty(_ difficulty: App.Coffee.Entities.Difficulty) async throws -> [App.Coffee.Entities.Coffee]
        func getCoffeesByType(_ type: App.Coffee.Entities.CoffeeType) async throws -> [App.Coffee.Entities.Coffee]
        func initializeDataIfNeeded() async throws
    }
}

