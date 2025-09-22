import Foundation

extension App.Coffee {
    @MainActor
    final class Repository: App.Coffee.Protocols.Manageable {
        private let persistence: App.Coffee.Persistence.Persistence

        init(persistence: App.Coffee.Persistence.Persistence) {
            self.persistence = persistence
        }

        func getAllCoffees() async throws -> [App.Coffee.Entities.Coffee] {
            try persistence.fetchAll()
        }

        func getCoffee(by id: UUID) async throws -> App.Coffee.Entities.Coffee? {
            try persistence.fetchByID(id)
        }

        func saveCoffee(_ coffee: App.Coffee.Entities.Coffee) async throws {
            try persistence.save(coffee)
        }

        func deleteCoffee(_ coffee: App.Coffee.Entities.Coffee) async throws {
            try persistence.delete(coffee)
        }

        func searchCoffees(query: String) async throws -> [App.Coffee.Entities.Coffee] {
            let allCoffees = try persistence.fetchAll()

            guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return allCoffees
            }

            return allCoffees.filter { coffee in
                coffee.name.localizedCaseInsensitiveContains(query) ||
                coffee.shortDescription.localizedCaseInsensitiveContains(query) ||
                coffee.ingredients.contains { ingredient in
                    ingredient.name.localizedCaseInsensitiveContains(query)
                }
            }
        }

        func getCoffeesByDifficulty(_ difficulty: App.Coffee.Entities.Difficulty) async throws -> [App.Coffee.Entities.Coffee] {
            let allCoffees = try persistence.fetchAll()
            return allCoffees.filter { $0.difficulty == difficulty }
        }

        func getCoffeesByType(_ type: App.Coffee.Entities.CoffeeType) async throws -> [App.Coffee.Entities.Coffee] {
            let allCoffees = try persistence.fetchAll()
            return allCoffees.filter { $0.coffeeType.contains(type) }
        }

        func initializeDataIfNeeded() async throws {
            try await persistence.importSampleDataIfNeeded()
        }
    }
}

