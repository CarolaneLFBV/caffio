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

        var body: some View {
            NavigationStack {
                VStack(spacing: App.DesignSystem.Padding.section) {
                    headerSection

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

                    Spacer()
                }
                .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
                .navigationTitle("coffee.maker.title")
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
    }
}

extension App.Coffee.Views.CoffeeMaker {
    var headerSection: some View {
        VStack(spacing: App.DesignSystem.Padding.component) {
            Image(systemName: App.DesignSystem.Icons.star)
                .font(.system(size: App.DesignSystem.Size.iconHuge))
                .foregroundStyle(.black)

            Text("app.intelligence.coffee.title")
                .font(.title2)
                .fontWeight(.semibold)

            Text("app.intelligence.coffee.subtitle")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(App.DesignSystem.Padding.large)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component))
    }

    var inputSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            Text("app.intelligence.coffee.input.title")
                .font(.headline)

            TextField("app.intelligence.coffee.input.placeholder",
                     text: $userPreferences,
                     axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(3, reservesSpace: true)

            Button(action: {
                Task {
                    await coffeeMaker?.generateCoffee(preferences: userPreferences)
                }
            }) {
                HStack {
                    Image(systemName: App.DesignSystem.Icons.star)
                    Text("app.coffee.intelligence.generate")
                }
                .frame(maxWidth: .infinity)
                .padding(App.DesignSystem.Padding.medium)
                .background(.black)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.element))
            }
            .disabled(userPreferences.isEmpty || coffeeMaker?.isGenerating == true)
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
        .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component))
    }



    func errorSection(message: String) -> some View {
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
        .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component))
    }
}

#Preview {
    App.Coffee.Views.CoffeeMaker()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
