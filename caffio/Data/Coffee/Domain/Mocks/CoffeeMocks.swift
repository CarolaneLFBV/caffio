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
        imageName: String? = "espresso",
        instructions: [String] = [
            "Grind coffee beans to fine espresso grind",
            "Preheat your espresso machine",
            "Extract shot in 25-30 seconds",
            "Serve immediately"
        ]
    ) -> App.Coffee.Entities.Coffee {
        let coffee = App.Coffee.Entities.Coffee(
            name: name,
            shortDescription: shortDescription,
            difficulty: difficulty,
            preparationTimeMinutes: preparationTimeMinutes,
            glassType: glassType,
            coffeeType: coffeeType,
            imageName: imageName,
            instructions: instructions
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
                imageName: "espresso",
                instructions: [
                    "Grind 18g of coffee beans to fine espresso grind",
                    "Preheat your espresso machine and portafilter",
                    "Dose and level the coffee in the portafilter",
                    "Tamp with 30lbs of pressure",
                    "Extract shot in 25-30 seconds for 36ml output",
                    "Serve immediately in preheated cup"
                ]
            ),
            .mock(
                name: "Cappuccino",
                shortDescription: "Espresso with steamed milk and foam",
                difficulty: .medium,
                preparationTimeMinutes: 5,
                glassType: .cup,
                coffeeType: [.hot],
                imageName: "cappuccino",
                instructions: [
                    "Prepare a double espresso shot following standard procedure",
                    "Pour cold milk into steaming pitcher",
                    "Steam milk to 65°C, creating microfoam",
                    "Pour steamed milk into espresso, holding foam back with spoon",
                    "Spoon remaining foam on top",
                    "Add sugar if desired and serve immediately"
                ]
            ),
            .mock(
                name: "Cold Brew",
                shortDescription: "Smooth and refreshing cold-extracted coffee",
                difficulty: .easy,
                preparationTimeMinutes: 5,
                glassType: .glass,
                coffeeType: [.cold, .long],
                imageName: "cold_brew",
                instructions: [
                    "Grind 80g coffee beans to coarse grind",
                    "Combine ground coffee with 500ml cold water",
                    "Stir well to ensure all grounds are saturated",
                    "Steep in refrigerator for 12-24 hours",
                    "Strain through fine mesh filter or cheesecloth",
                    "Serve over ice in a glass"
                ]
            ),
            .mock(
                name: "Latte",
                shortDescription: "Creamy espresso with lots of steamed milk",
                difficulty: .medium,
                preparationTimeMinutes: 6,
                glassType: .mug,
                coffeeType: [.hot, .long],
                imageName: "latte",
                instructions: [
                    "Prepare a double espresso shot",
                    "Pour cold milk into steaming pitcher",
                    "Steam milk to 65°C with minimal foam",
                    "Pour steamed milk into espresso, creating latte art if desired",
                    "Add vanilla syrup and stir gently",
                    "Serve in a large mug"
                ]
            ),
            .mock(
                name: "Pour Over V60",
                shortDescription: "Precision brewing method for clean, bright flavors",
                difficulty: .hard,
                preparationTimeMinutes: 12,
                glassType: .v60,
                coffeeType: [.hot, .filtered],
                imageName: "v60",
                instructions: [
                    "Heat water to 92°C",
                    "Grind 22g coffee beans to medium-fine grind",
                    "Place filter in V60 and rinse with hot water",
                    "Add ground coffee and create a small well",
                    "Start timer and pour 50ml water in circular motion (bloom)",
                    "Wait 30 seconds, then pour remaining water slowly in stages",
                    "Total brew time should be 2:30-3:00 minutes"
                ]
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
            imageName: "mocha",
            instructions: [
                "Mix chocolate powder with brown sugar in mug",
                "Add a small amount of hot water to create paste",
                "Prepare a double espresso shot",
                "Pour espresso into chocolate mixture and stir",
                "Steam milk to 65°C",
                "Pour steamed milk and top with whipped cream"
            ]
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
