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
            print("🖼️ Using imageName: '\(imageName)' for coffee: '\(name)'")
            return Image(imageName)
        }

        let nameTrimmed = name
            .lowercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "_", with: "")
        
        print("🖼️ Using trimmed name: '\(nameTrimmed)' for coffee: '\(name)'")

        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }

        return Image(nameTrimmed.isEmpty ? "defaultpic" : nameTrimmed)
    }
    
    @Transient
    var difficultyColor: Color {
        switch difficulty {
        case .easy: return .green
        case .medium: return .yellow
        case .hard: return .red
        }
    }
}
