import SwiftUI
import Foundation

extension App.Coffee.Entities {
    struct Converted: Codable {
        let name: String
        let shortDescription: String
        let difficulty: App.Coffee.Entities.Difficulty
        let preparationTimeMinutes: Int
        let glassType: App.Coffee.Entities.GlassType
        let coffeeType: [App.Coffee.Entities.CoffeeType]
        let imageName: String?
        let instructions: [String]
        let ingredients: [App.Ingredient.Entities.Converted]
    }
}
