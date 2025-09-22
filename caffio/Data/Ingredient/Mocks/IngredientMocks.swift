import Foundation

#if DEBUG
extension App.Ingredient.Entities.Ingredient {
    static func mock(
        name: String = "Mock Ingredient",
        measure: Double = 1.0,
        units: String = "unit"
    ) -> App.Ingredient.Entities.Ingredient {
        App.Ingredient.Entities.Ingredient(
            name: name,
            measure: measure,
            units: units
        )
    }

    static var previewSamples: [App.Ingredient.Entities.Ingredient] {
        [
            .mock(name: "Espresso ground coffee", measure: 18, units: "g"),
            .mock(name: "Hot water", measure: 250, units: "ml"),
            .mock(name: "Whole milk", measure: 200, units: "ml"),
            .mock(name: "White sugar", measure: 2, units: "tsp"),
            .mock(name: "Vanilla syrup", measure: 1, units: "pump"),
            .mock(name: "Ice cubes", measure: 6, units: "pieces"),
            .mock(name: "Chocolate powder", measure: 1, units: "tsp"),
            .mock(name: "Whipped cream", measure: 30, units: "ml"),
            .mock(name: "Cinnamon powder", measure: 1, units: "pinch"),
            .mock(name: "Brown sugar", measure: 1, units: "tsp")
        ]
    }

    static var commonIngredients: [App.Ingredient.Entities.Ingredient] {
        [
            .mock(name: "Espresso ground coffee", measure: 18, units: "g"),
            .mock(name: "Filter ground coffee", measure: 25, units: "g"),
            .mock(name: "Hot water", measure: 200, units: "ml"),
            .mock(name: "Cold water", measure: 200, units: "ml"),
            .mock(name: "Whole milk", measure: 150, units: "ml"),
            .mock(name: "Almond milk", measure: 150, units: "ml"),
            .mock(name: "White sugar", measure: 1, units: "tsp"),
            .mock(name: "Ice cubes", measure: 4, units: "pieces")
        ]
    }

    static var specialtyIngredients: [App.Ingredient.Entities.Ingredient] {
        [
            .mock(name: "Vanilla syrup", measure: 1, units: "pump"),
            .mock(name: "Caramel syrup", measure: 1, units: "pump"),
            .mock(name: "Chocolate powder", measure: 2, units: "tsp"),
            .mock(name: "Whipped cream", measure: 30, units: "ml"),
            .mock(name: "Cinnamon powder", measure: 1, units: "pinch"),
            .mock(name: "Cardamom", measure: 2, units: "pods"),
            .mock(name: "Honey", measure: 1, units: "tsp"),
            .mock(name: "Maple syrup", measure: 1, units: "tsp")
        ]
    }
}
#endif
