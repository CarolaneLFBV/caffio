import Foundation
import FoundationModels
import SwiftData

extension App.Coffee.AI {
    @MainActor @Observable
    class CoffeeMaker {
        var isGenerating = false
        var generatedCoffee: CoffeeGenerable?
        var errorMessage: String?

        private var modelContext: ModelContext

        init(modelContext: ModelContext) {
            self.modelContext = modelContext
        }

        // MARK: - Error Types
        enum CoffeeGenerationError: LocalizedError {
            case noResponse
            case missingFields([String])
            case incompleteIngredient

            var errorDescription: String? {
                switch self {
                case .noResponse:
                    return "No response received from AI"
                case .missingFields(let fields):
                    return "Generated coffee recipe is missing: \(fields.joined(separator: ", "))"
                case .incompleteIngredient:
                    return "Incomplete ingredient data"
                }
            }
        }

        func generateCoffee(preferences: String) async {
            isGenerating = true
            errorMessage = nil
            generatedCoffee = nil

            defer { isGenerating = false }

            do {
                let partial = try await performGeneration(preferences: preferences)
                let validatedCoffee = try validateAndBuild(from: partial)
                generatedCoffee = validatedCoffee
            } catch {
                errorMessage = "Failed to generate coffee: \(error.localizedDescription)"
            }
        }

        // MARK: - Private Methods
        private func performGeneration(preferences: String) async throws -> CoffeeGenerable.PartiallyGenerated {
            let session = LanguageModelSession(
                instructions: Instructions {
                    "You are a professional coffee recipe creator."
                    "Create unique and realistic coffee recipes based on user preferences."
                }
            )

            let stream = session.streamResponse(generating: CoffeeGenerable.self) {
                "Create a unique coffee recipe based on these preferences: \(preferences)"
                ""
                "Please provide a complete coffee recipe with:"
                "- A creative and appealing name"
                "- A brief description (2-3 sentences)"
                "- Appropriate difficulty level (easy, medium, or hard)"
                "- Realistic preparation time in minutes"
                "- Suitable glass type (cup, mug, glass, tumbler, frenchPress, chemex, v60)"
                "- Coffee characteristics (hot, cold, short, long, iced, filtered)"
                "- Detailed step-by-step instructions"
                "- Complete ingredient list with measurements"
                ""
                "Make sure the recipe is realistic and achievable."
            }

            var latestPartial: CoffeeGenerable.PartiallyGenerated?
            for try await partialResponse in stream {
                latestPartial = partialResponse.content
            }

            guard let partial = latestPartial else {
                throw CoffeeGenerationError.noResponse
            }

            return partial
        }

        private func validateAndBuild(from partial: CoffeeGenerable.PartiallyGenerated) throws -> CoffeeGenerable {
            let missingFields = validateRequiredFields(partial)
            guard missingFields.isEmpty else {
                throw CoffeeGenerationError.missingFields(missingFields)
            }

            let ingredients = try buildIngredients(from: partial.ingredients!)

            return CoffeeGenerable(
                name: partial.name!,
                shortDescription: partial.shortDescription!,
                difficulty: partial.difficulty!,
                preparationTimeMinutes: partial.preparationTimeMinutes!,
                glassType: partial.glassType!,
                coffeeTypes: partial.coffeeTypes!,
                instructions: partial.instructions!,
                ingredients: ingredients
            )
        }

        private func validateRequiredFields(_ partial: CoffeeGenerable.PartiallyGenerated) -> [String] {
            var missingFields: [String] = []

            if partial.name == nil { missingFields.append("name") }
            if partial.shortDescription == nil { missingFields.append("shortDescription") }
            if partial.difficulty == nil { missingFields.append("difficulty") }
            if partial.preparationTimeMinutes == nil { missingFields.append("preparationTimeMinutes") }
            if partial.glassType == nil { missingFields.append("glassType") }
            if partial.coffeeTypes == nil { missingFields.append("coffeeTypes") }
            if partial.instructions == nil { missingFields.append("instructions") }
            if partial.ingredients == nil { missingFields.append("ingredients") }

            return missingFields
        }

        private func buildIngredients(from partials: [App.Ingredient.AI.IngredientGenerable.PartiallyGenerated]) throws -> [App.Ingredient.AI.IngredientGenerable] {
            return try partials.map { partial in
                guard let name = partial.name,
                      let measure = partial.measure,
                      let units = partial.units else {
                    throw CoffeeGenerationError.incompleteIngredient
                }

                return App.Ingredient.AI.IngredientGenerable(
                    name: name,
                    measure: measure,
                    units: units
                )
            }
        }

        func saveCoffee() {
            guard let generatedCoffee = generatedCoffee else { return }

            let coffeeEntity = generatedCoffee.toCoffeeEntity()
            modelContext.insert(coffeeEntity)

            do {
                try modelContext.save()
                self.generatedCoffee = nil
            } catch {
                errorMessage = "Failed to save coffee: \(error.localizedDescription)"
            }
        }

        func clearGeneration() {
            generatedCoffee = nil
            errorMessage = nil
        }
    }
}
