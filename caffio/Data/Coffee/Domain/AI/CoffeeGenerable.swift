import Foundation
import FoundationModels

extension App.Coffee.AI {
    @Generable
    struct CoffeeGenerable: Equatable {
        let name: String
        let shortDescription: String
        let difficulty: String
        let preparationTimeMinutes: Int
        let glassType: String
        let coffeeTypes: [String]
        let instructions: [String]
        let ingredients: [App.Ingredient.AI.IngredientGenerable]
    }
}

// MARK: - Conversion Extensions
extension App.Coffee.AI.CoffeeGenerable {
    func toCoffeeEntity() -> App.Coffee.Entities.Coffee {
        return App.Coffee.Entities.Coffee(
            name: self.name,
            shortDescription: self.shortDescription,
            difficulty: App.Coffee.Entities.Difficulty(rawValue: self.difficulty) ?? .medium,
            preparationTimeMinutes: self.preparationTimeMinutes,
            glassType: App.Coffee.Entities.GlassType(rawValue: self.glassType) ?? .cup,
            coffeeType: self.coffeeTypes.compactMap { App.Coffee.Entities.CoffeeType(rawValue: $0) },
            instructions: self.instructions,
            ingredients: self.ingredients.map { $0.toIngredientEntity() }
        )
    }
}
