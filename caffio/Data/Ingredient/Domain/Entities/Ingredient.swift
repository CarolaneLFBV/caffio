import Foundation
import SwiftData

extension App.Ingredient.Entities {
    @Model
    final class Ingredient {
        @Attribute(.unique)
        var id: UUID
        var name: String
        var measure: Double
        var units: String

        @Relationship(deleteRule: .nullify)
        var coffees: [App.Coffee.Entities.Coffee]

        init(
            id: UUID = UUID(),
            name: String = "",
            measure: Double = 0,
            units: String = "",
            coffees: [App.Coffee.Entities.Coffee] = []
        ) {
            self.id = id
            self.name = name
            self.measure = measure
            self.units = units
            self.coffees = coffees
        }
    }
}
