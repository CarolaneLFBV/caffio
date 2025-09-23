import Foundation
import SwiftData
import SwiftUI

extension App.Coffee.Entities {
    @Model
    final class Coffee {
        @Attribute(.unique)
        var id: UUID

        @Attribute(.unique)
        var name: String

        var shortDescription: String
        var difficulty: Difficulty
        var preparationTimeMinutes: Int
        var glassType: GlassType
        var coffeeType: [CoffeeType]
        
        @Attribute(.externalStorage)
        var imageData: Data?
        var imageName: String?
        var instructions: [String]

        @Relationship(deleteRule: .cascade)
        var ingredients: [App.Ingredient.Entities.Ingredient]
        
        init(
            id: UUID = UUID(),
            name: String = "",
            shortDescription: String = "",
            difficulty: Difficulty = .easy,
            preparationTimeMinutes: Int = 0,
            glassType: GlassType = .cup,
            coffeeType: [CoffeeType] = [],
            imageData: Data? = nil,
            imageName: String? = nil,
            instructions: [String] = [],
            ingredients: [App.Ingredient.Entities.Ingredient] = []
        ) {
            self.id = id
            self.name = name
            self.shortDescription = shortDescription
            self.difficulty = difficulty
            self.preparationTimeMinutes = preparationTimeMinutes
            self.glassType = glassType
            self.coffeeType = coffeeType
            self.imageData = imageData
            self.imageName = imageName
            self.instructions = instructions
            self.ingredients = ingredients
        }
    }
}

extension App.Coffee.Entities.Coffee {
    @Transient
    var preparationTimeFormatted: String {
        String(localized: "\(preparationTimeMinutes) minute")
    }
    
    @Transient
    var displayedImage: Image {
        if let imageName = imageName {
            return Image(imageName)
        }

        let nameTrimmed = name
            .lowercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "_", with: "")
        
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }

        return Image(nameTrimmed.isEmpty ? "defaultpic" : nameTrimmed)
    }

    @Transient
    var difficultyStars: Int {
        switch difficulty {
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        }
    }
}
