import Foundation
import SwiftData
import SwiftUI

extension App.Coffee.Entities {
    @Model
    final class Model {
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
        var ingredients: [App.Ingredient.Entities.Model] = []
        
        init(
            id: UUID = UUID(),
            name: String = "",
            shortDescription: String = "",
            difficulty: Difficulty = .easy,
            preparationTimeMinutes: Int = 0,
            glassType: GlassType = .cup,
            coffeeType: [CoffeeType] = [],
            imageData: Data? = nil,
            imageName: String? = nil
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
        }
    }
}

extension App.Coffee.Entities.Model {
    @Transient
    var preparationTimeFormatted: String {
        String(localized: "\(preparationTimeMinutes) minute")
    }
    
    @Transient
    var displayedImage: Image {
        if let name = imageName {
            return Image(name)
        }
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return Image("defaultpic")
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
