import SwiftUI
import SwiftData

extension App.Home.Views {
    struct Home: View {
        @Environment(\.modelContext) private var modelContext

        @Query(sort: \App.Coffee.Entities.Coffee.name)
        private var coffees: [App.Coffee.Entities.Coffee]

        @State private var selectedCoffee: App.Coffee.Entities.Coffee?
        
        @State private var showCoffeeMaker = false
        @State private var showCoffeeList = false
        @State private var showShelfList = false
        
        @Namespace private var namespace

        var body: some View {
            NavigationStack {
                ScrollView {
                    content
                }
                .navigationTitle("app.name")
                .navigationDestination(item: $selectedCoffee) { coffee in
                    App.Coffee.Views.Detail(coffee: coffee)
                        .navigationTransition(.zoom(sourceID: coffee.id, in: namespace))
                }
                .navigationDestination(isPresented: $showCoffeeMaker) {
                    App.Coffee.Views.CoffeeMaker()
                }
                .navigationDestination(isPresented: $showCoffeeList) {
                    App.Coffee.Views.List()
                }
                .navigationDestination(isPresented: $showShelfList) {
                    App.Coffee.Views.ShelfList()
                }
            }
        }

        private func sectionHeader(_ titleKey: LocalizedStringKey) -> some View {
            Text(titleKey)
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}

extension App.Home.Views.Home {
    var content: some View {
        VStack(spacing: App.DesignSystem.Padding.section) {
            popularCoffeesSection
            appleIntelligenceSection
            Spacer()
        }
        .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
    }

    var popularCoffeesSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            HStack {
                sectionHeader("coffee.your.list")
                Spacer()
                NavigationLink(destination: App.Coffee.Views.List()) {
                    Text("app.more")
                        .font(.body)
                        .foregroundStyle(.blue)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: App.DesignSystem.Padding.component) {
                    ForEach(Array(coffees.prefix(5)), id: \.id) { coffee in
                        App.Coffee.Components.Card(
                            coffee: coffee,
                            action: {
                                selectedCoffee = coffee
                            },
                            namespace: namespace
                        )
                    }
                }
                .padding(.horizontal, App.DesignSystem.Padding.tight)
            }
        }
    }

    var appleIntelligenceSection: some View {
        VStack(alignment: .leading) {
            sectionHeader("home.section.inspiration")
            
            Button(action: {
                showCoffeeMaker = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium)
                        .fill(
                            LinearGradient(
                                colors: [.black, .brown, .gray],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: App.DesignSystem.Size.cardMediumHeight)

                    VStack(alignment: .leading, spacing: App.DesignSystem.Padding.element) {
                        HStack {
                            Image(systemName: App.DesignSystem.Icons.intelligence)
                                .foregroundColor(.white)
                                .font(.title2)

                            Text("app.intelligence")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.medium)

                            Spacer()
                        }

                        Text("app.intelligence.description")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)

                        Spacer()
                    }
                    .padding(App.DesignSystem.Padding.large)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    App.Home.Views.Home()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
