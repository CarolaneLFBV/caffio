//
//  IngredientGenerable.swift
//  caffio
//
//  Created by Carolane Lefebvre on 23/09/2025.
//

import FoundationModels
import Foundation

extension App.Ingredient.AI {
    @Generable
    struct IngredientGenerable: Equatable {
        let name: String
        let measure: Double
        let units: String
    }
}

// MARK: - Conversion Extensions
extension App.Ingredient.AI.IngredientGenerable {
    func toIngredientEntity() -> App.Ingredient.Entities.Ingredient {
        return App.Ingredient.Entities.Ingredient(
            name: self.name,
            measure: self.measure,
            units: self.units
        )
    }
}
