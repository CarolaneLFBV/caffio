import SwiftData
import Foundation

extension App.Core {
    struct Config {
        static var shared = Config()
        private static let hasPrePopulatedKey = "com.caffio.hasPrePopulated"

        lazy var container: ModelContainer = {
            let schema = Schema([
                App.Coffee.Entities.Coffee.self,
                App.Ingredient.Entities.Ingredient.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                let container = try ModelContainer(
                    for: schema,
                    configurations: [modelConfiguration]
                )
                try prePopulateIfNeeded(container: container)

                return container
            } catch {
                fatalError("Could not create ModelContainer: \(error.localizedDescription)")
            }
        }()

        static func resetPrePopulateFlag() {
            UserDefaults.standard.removeObject(forKey: hasPrePopulatedKey)
        }
    }
}

// MARK: - Pre-populate Logic
extension App.Core.Config {
    private func prePopulateIfNeeded(container: ModelContainer) throws {
        let hasPrePopulated = UserDefaults.standard.bool(forKey: Self.hasPrePopulatedKey)
        guard !hasPrePopulated else { return }

        let context = container.mainContext
        let coffeeCount = (try? context.fetchCount(FetchDescriptor<App.Coffee.Entities.Coffee>())) ?? 0

        if coffeeCount > 0 {
            UserDefaults.standard.set(true, forKey: Self.hasPrePopulatedKey)
            return
        }

        do {
            try importSampleData(context: context)
            UserDefaults.standard.set(true, forKey: Self.hasPrePopulatedKey)
        } catch {
            throw error
        }
    }

    private func importSampleData(context: ModelContext) throws {
        let convertedCoffees = try App.Core.Utils.getCoffees()

        for coffeeData in convertedCoffees {
            let coffee = createCoffeeEntity(from: coffeeData)
            context.insert(coffee)
        }

        try context.save()
    }

    private func createCoffeeEntity(from converted: App.Coffee.Entities.Converted) -> App.Coffee.Entities.Coffee {
        let coffee = App.Coffee.Entities.Coffee(
            name: converted.name,
            shortDescription: converted.shortDescription,
            difficulty: converted.difficulty,
            preparationTimeMinutes: converted.preparationTimeMinutes,
            glassType: converted.glassType,
            coffeeType: converted.coffeeType,
            imageName: converted.imageName,
            instructions: converted.instructions
        )

        for ingredientData in converted.ingredients {
            let ingredient = App.Ingredient.Entities.Ingredient(
                name: ingredientData.name,
                measure: ingredientData.measure,
                units: ingredientData.units
            )
            coffee.ingredients.append(ingredient)
        }

        return coffee
    }
}
