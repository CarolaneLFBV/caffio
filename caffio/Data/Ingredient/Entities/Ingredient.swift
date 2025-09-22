import Foundation
import SwiftData

extension App.Ingredient.Entities {
    @Model
    final class Model {
        @Attribute(.unique)
        var id: UUID
        var name: String
        var measure: Double
        var units: String

        @Relationship(deleteRule: .nullify, inverse: \App.Coffee.Entities.Model.ingredients)
        var coffees: [App.Coffee.Entities.Model] = []

        init(
            id: UUID = UUID(),
            name: String = "",
            measure: Double = 0,
            units: String = ""
        ) {
            self.id = id
            self.name = name
            self.measure = measure
            self.units = units
        }
    }
}
