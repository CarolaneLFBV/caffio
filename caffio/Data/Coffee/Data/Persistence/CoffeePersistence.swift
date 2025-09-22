import Foundation
import SwiftData

extension App.Coffee.Persistence {
    final class Persistence: App.Coffee.Protocols.Storable {
        private let modelContext: ModelContext

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        func fetchAll() throws -> [App.Coffee.Entities.Model] {
            let descriptor = FetchDescriptor<App.Coffee.Entities.Model>(
                sortBy: [SortDescriptor(\.name)]
            )
            return try modelContext.fetch(descriptor)
        }

        func fetchByID(_ id: UUID) throws -> App.Coffee.Entities.Model? {
            let descriptor = FetchDescriptor<App.Coffee.Entities.Model>(
                predicate: #Predicate { $0.id == id }
            )
            return try modelContext.fetch(descriptor).first
        }

        func save(_ coffee: App.Coffee.Entities.Model) throws {
            modelContext.insert(coffee)
            try modelContext.save()
        }

        func delete(_ coffee: App.Coffee.Entities.Model) throws {
            modelContext.delete(coffee)
            try modelContext.save()
        }

        func importSampleDataIfNeeded() async throws {
            let coffeeCount = try modelContext.fetchCount(FetchDescriptor<App.Coffee.Entities.Model>())
            guard coffeeCount == 0 else { return }

            try await importSampleCoffees()
        }

        private func importSampleCoffees() async throws {
            guard let url = Bundle.main.url(forResource: "coffees", withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                fatalError("unable to find json")
            }

            let decoder = JSONDecoder()
            let sampleData = try decoder.decode(SampleCoffeeData.self, from: data)

            for coffeeData in sampleData.coffees {
                let coffee = createCoffee(from: coffeeData)
                modelContext.insert(coffee)
            }

            try modelContext.save()
        }

        private func createCoffee(from data: SampleCoffee) -> App.Coffee.Entities.Model {
            let coffee = App.Coffee.Entities.Model(
                name: data.name,
                shortDescription: data.shortDescription,
                difficulty: data.difficulty,
                preparationTimeMinutes: data.preparationTimeMinutes,
                glassType: data.glassType,
                coffeeType: data.coffeeType,
                imageName: data.imageName
            )

            for ingredientData in data.ingredients {
                let ingredient = App.Ingredient.Entities.Model(
                    name: ingredientData.name,
                    measure: ingredientData.measure,
                    units: ingredientData.units
                )
                coffee.ingredients.append(ingredient)
            }

            return coffee
        }
    }
}

private struct SampleCoffeeData: Codable {
    let coffees: [SampleCoffee]
}

private struct SampleCoffee: Codable {
    let name: String
    let shortDescription: String
    let difficulty: App.Coffee.Entities.Difficulty
    let preparationTimeMinutes: Int
    let glassType: App.Coffee.Entities.GlassType
    let coffeeType: [App.Coffee.Entities.CoffeeType]
    let imageName: String?
    let ingredients: [SampleIngredient]
}

private struct SampleIngredient: Codable {
    let name: String
    let measure: Double
    let units: String
}
