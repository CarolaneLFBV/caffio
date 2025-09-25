import SwiftUI

extension App.Ingredient.Views {
    struct List: View {
        let ingredients: [App.Ingredient.Entities.Ingredient]

        var body: some View {
            VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
                Text("coffee.ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack(spacing: App.DesignSystem.Padding.element) {
                    ForEach(ingredients, id: \.id) { ingredient in
                        ingredientRow(ingredient)
                    }
                }
            }
            .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
        }

        private func ingredientRow(_ ingredient: App.Ingredient.Entities.Ingredient) -> some View {
            HStack(spacing: App.DesignSystem.Padding.component) {
                Circle()
                    .fill(.primary)
                    .frame(width: App.DesignSystem.Size.xsmall, height: App.DesignSystem.Size.xsmall)
                HStack {
                    Text(ingredient.name)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("\(ingredient.measure.formatted()) \(ingredient.units)")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    App.Ingredient.Views.List(ingredients: App.Ingredient.Entities.Ingredient.previewSamples)
}
