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
        
        var isFavorite: Bool
        var note: Int
        
        @Attribute(.externalStorage)
        var imageData: Data?
        var imageName: String?
        var instructions: [String]

        @Relationship(deleteRule: .nullify)
        var ingredients: [App.Ingredient.Entities.Ingredient]
        
        init(
            id: UUID = UUID(),
            name: String = "",
            shortDescription: String = "",
            difficulty: Difficulty = .easy,
            preparationTimeMinutes: Int = 0,
            glassType: GlassType = .cup,
            coffeeType: [CoffeeType] = [],
            isFavorite: Bool = false,
            note: Int = 0,
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
            self.isFavorite = isFavorite
            self.note = note
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
        String(localized: "\(preparationTimeMinutes) min")
    }
    
    @Transient
    var displayedImage: Image {
        if let imageName = imageName, !imageName.isEmpty {
            return Image(imageName)
        }

        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }

        let nameTrimmed = name
            .lowercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "_", with: "")

        if !nameTrimmed.isEmpty && UIImage(named: nameTrimmed) != nil {
            return Image(nameTrimmed)
        }

        return Image("defaultpic")
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
