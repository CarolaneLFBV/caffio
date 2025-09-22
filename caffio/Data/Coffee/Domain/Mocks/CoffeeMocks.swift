import Foundation

#if DEBUG
extension App.Coffee.Entities.Coffee {
    static func mock(
        name: String = "Mock Espresso",
        shortDescription: String = "A rich and intense shot of pure coffee",
        difficulty: App.Coffee.Entities.Difficulty = .easy,
        preparationTimeMinutes: Int = 2,
        glassType: App.Coffee.Entities.GlassType = .cup,
        coffeeType: [App.Coffee.Entities.CoffeeType] = [.hot, .short],
        imageName: String? = "espresso"
    ) -> App.Coffee.Entities.Coffee {
        let coffee = App.Coffee.Entities.Coffee(
            name: name,
            shortDescription: shortDescription,
            difficulty: difficulty,
            preparationTimeMinutes: preparationTimeMinutes,
            glassType: glassType,
            coffeeType: coffeeType,
            imageName: imageName
        )

        coffee.ingredients.append(App.Ingredient.Entities.Ingredient.mock(
            name: "Espresso ground coffee",
            measure: 18,
            units: "g"
        ))
        coffee.ingredients.append(App.Ingredient.Entities.Ingredient.mock(
            name: "Hot water",
            measure: 36,
            units: "ml"
        ))

        return coffee
    }

    static var previewSamples: [App.Coffee.Entities.Coffee] {
        [
            .mock(
                name: "Classic Espresso",
                shortDescription: "A rich and intense shot of pure coffee",
                difficulty: .easy,
                preparationTimeMinutes: 2,
                glassType: .cup,
                coffeeType: [.hot, .short],
                imageName: "espresso"
            ),
            .mock(
                name: "Cappuccino",
                shortDescription: "Espresso with steamed milk and foam",
                difficulty: .medium,
                preparationTimeMinutes: 5,
                glassType: .cup,
                coffeeType: [.hot],
                imageName: "cappuccino"
            ),
            .mock(
                name: "Cold Brew",
                shortDescription: "Smooth and refreshing cold-extracted coffee",
                difficulty: .easy,
                preparationTimeMinutes: 5,
                glassType: .glass,
                coffeeType: [.cold, .long],
                imageName: "cold_brew"
            ),
            .mock(
                name: "Latte",
                shortDescription: "Creamy espresso with lots of steamed milk",
                difficulty: .medium,
                preparationTimeMinutes: 6,
                glassType: .mug,
                coffeeType: [.hot, .long],
                imageName: "latte"
            ),
            .mock(
                name: "Pour Over V60",
                shortDescription: "Precision brewing method for clean, bright flavors",
                difficulty: .hard,
                preparationTimeMinutes: 12,
                glassType: .v60,
                coffeeType: [.hot, .filtered],
                imageName: "v60"
            )
        ]
    }

    static var complexMock: App.Coffee.Entities.Coffee {
        let coffee = App.Coffee.Entities.Coffee(
            name: "Complex Mocha",
            shortDescription: "Decadent chocolate espresso drink with multiple ingredients",
            difficulty: .hard,
            preparationTimeMinutes: 7,
            glassType: .mug,
            coffeeType: [.hot],
            imageName: "mocha"
        )

        let ingredients = [
            App.Ingredient.Entities.Ingredient.mock(name: "Espresso ground coffee", measure: 18, units: "g"),
            App.Ingredient.Entities.Ingredient.mock(name: "Whole milk", measure: 150, units: "ml"),
            App.Ingredient.Entities.Ingredient.mock(name: "Chocolate powder", measure: 2, units: "tsp"),
            App.Ingredient.Entities.Ingredient.mock(name: "Whipped cream", measure: 30, units: "ml"),
            App.Ingredient.Entities.Ingredient.mock(name: "Brown sugar", measure: 1, units: "tsp")
        ]

        coffee.ingredients.append(contentsOf: ingredients)
        return coffee
    }
}
#endif
