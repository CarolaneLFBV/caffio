import SwiftUI

extension App.Coffee.Views {
    struct Detail: View {
        let coffee: App.Coffee.Entities.Coffee
        @State private var isVisible = false

        var body: some View {
            ScrollView {
                content
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    isVisible = true
                }
            }
        }
        
        private var coffeeTypeText: String {
            if coffee.coffeeType.isEmpty {
                return "No type specified"
            } else if coffee.coffeeType.count == 1 {
                return coffee.coffeeType.first?.displayName ?? ""
            } else {
                return coffee.coffeeType.map { $0.displayName }.joined(separator: " • ")
            }
        }
    }
}

extension App.Coffee.Views.Detail {
    var content: some View {
        VStack(spacing: App.DesignSystem.Padding.section) {
            App.Coffee.Components.Header(coffee: coffee)
                .overlay(alignment: .bottom) {
                    header
                        .offset(y: isVisible ? -10 : 10)
                        .opacity(isVisible ? 1.0 : 0.0)
                }
            information
            ingredients
            instructions
        }
        .scaleEffect(isVisible ? 1.0 : 1.1)
        .opacity(isVisible ? 1.0 : 0.0)
    }
    
    var header: some View {
        VStack(spacing: App.DesignSystem.Padding.tight) {
            Text(coffee.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(coffeeTypeText)
                .font(.caption)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            Text(coffee.shortDescription)
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
    }
    
    var information: some View {
        App.Coffee.Components.Information(coffee: coffee)
    }
    
    var ingredients: some View {
        App.Ingredient.Views.List(ingredients: coffee.ingredients)
    }
    
    var instructions: some View {
        App.Coffee.Components.Instruction(coffee: coffee)
    }
}

#Preview {
    App.Coffee.Views.Detail(coffee: App.Coffee.Entities.Coffee.complexMock)
}
