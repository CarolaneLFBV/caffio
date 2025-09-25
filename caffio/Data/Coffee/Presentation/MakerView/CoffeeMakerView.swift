import SwiftUI
import SwiftData
import FoundationModels

extension App.Coffee.Views {
    struct CoffeeMaker: View {
        @Environment(\.modelContext) private var modelContext
        @State private var coffeeMaker: App.Coffee.AI.CoffeeMaker?
        @State private var userPreferences = ""
        @State private var showSaveSuccess = false
        @State private var showGeneratedCoffeeSheet = false
        @State private var isAnimating = false
        
        @Namespace private var intelligentCoffeeMaker
        
        var body: some View {
            NavigationStack {
                VStack {
                    App.DesignSystem.Components.HeaderMesh()
                        .overlay {
                            headerSection
                        }
                        .ignoresSafeArea()
                        .onAppear {
                            withAnimation(.linear(duration: 7).repeatForever(autoreverses: false)) {
                                isAnimating = true
                            }
                        }
                    content
                }
                .onAppear {
                    if coffeeMaker == nil {
                        coffeeMaker = App.Coffee.AI.CoffeeMaker(modelContext: modelContext)
                    }
                }
                .onChange(of: coffeeMaker?.generatedCoffee) { _, newCoffee in
                    if newCoffee != nil {
                        showGeneratedCoffeeSheet = true
                    }
                }
                .sheet(isPresented: $showGeneratedCoffeeSheet) {
                    if let coffee = coffeeMaker?.generatedCoffee,
                       let coffeeMaker = coffeeMaker {
                        GeneratedCoffeeSheet(
                            coffee: coffee,
                            coffeeMaker: coffeeMaker,
                            isPresented: $showGeneratedCoffeeSheet,
                            showSaveSuccess: $showSaveSuccess
                        )
                    }
                }
                .alert("coffee.alert.saved.title", isPresented: $showSaveSuccess) {
                    Button("app.ok") { }
                } message: {
                    Text("coffee.alert.saved.message")
                }
            }
        }
        
        private func errorSection(message: String) -> some View {
            VStack(spacing: App.DesignSystem.Padding.component) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: App.DesignSystem.Size.iconLarge))
                    .foregroundStyle(.red)
                
                Text("app.error")
                    .font(.headline)
                
                Text(message)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                
                Button("app.retry") {
                    coffeeMaker?.clearGeneration()
                }
                .padding(App.DesignSystem.Padding.medium)
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.element))
            }
            .padding(App.DesignSystem.Padding.large)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium))
        }
    }
}

private extension App.Coffee.Views.CoffeeMaker {
    var content: some View {
        VStack(spacing: App.DesignSystem.Padding.component) {
            if let coffeeMaker = coffeeMaker {
                inputSection
                
                if coffeeMaker.isGenerating {
                    generatingSection
                }
                
                if let errorMessage = coffeeMaker.errorMessage {
                    errorSection(message: errorMessage)
                }
            } else {
                ProgressView("app.intelligence.loading")
            }
            Spacer(minLength: 40)
        }
        .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
    }
    
    var headerSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            Spacer()
            
            HStack {
                Image(systemName: App.DesignSystem.Icons.intelligence)
                    .font(.system(size: App.DesignSystem.Size.iconHuge))
                
                Text("app.intelligence.coffee.title")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("app.intelligence.coffee.subtitle")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(App.DesignSystem.Padding.large)
        .foregroundStyle(.primary)
    }
    
    var inputSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            Text("app.intelligence.coffee.input.title")
                .font(.headline)

            TextEditor(text: $userPreferences)
                .overlay {
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.small)
                            .fill(.secondary.opacity(0.1))
                        
                        if userPreferences.isEmpty {
                            Text("app.intelligence.coffee.input.placeholder")
                                .foregroundColor(.secondary)
                                .padding(App.DesignSystem.Padding.element)
                        }
                    }
                    .allowsHitTesting(false)
                }
            
            Spacer()
            
            Button(action: {
                Task {
                    await coffeeMaker?.generateCoffee(preferences: userPreferences)
                }
            }) {
                App.Coffee.Components.IntelligentButton(boolInput: isAnimating)
            }
        }
    }
    
    var generatingSection: some View {
        VStack(spacing: App.DesignSystem.Padding.component) {
            ProgressView()
                .scaleEffect(1.2)
            
            Text("app.intelligence.coffee.generating")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(App.DesignSystem.Padding.large)
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium))
    }
}

#Preview {
    App.Coffee.Views.CoffeeMaker()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
