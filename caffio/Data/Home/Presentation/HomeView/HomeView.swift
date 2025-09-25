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
        @State private var showCreateCoffee = false
        
        @Namespace private var namespace
        @Namespace private var intelligentCoffeeMaker

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
                        .navigationTransition(.zoom(sourceID: "intelligence", in: intelligentCoffeeMaker))
                }
                .navigationDestination(isPresented: $showCoffeeList) {
                    App.Coffee.Views.List()
                }
                .navigationDestination(isPresented: $showShelfList) {
                    App.Coffee.Views.ShelfList()
                }
                .sheet(isPresented: $showCreateCoffee) {
                    App.Coffee.Views.Editor(mode: .create)
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
            quickActionsSection
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
                App.Home.Components.IntelligenceBadge()
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            sectionHeader("home.section.quickActions")

            HStack(spacing: App.DesignSystem.Padding.component) {
                Button(action: {
                    showCreateCoffee = true
                }) {
                    App.Home.Components.QuickActionButton(
                        title: "coffee.new",
                        subtitle: "coffee.new.subtitle",
                        imageName: App.DesignSystem.Icons.new
                    )
                }
                .buttonStyle(PlainButtonStyle())

                Button(action: {
                    showShelfList = true
                }) {
                    App.Home.Components.QuickActionButton(
                        title: "app.favorite.browse.title",
                        subtitle: "app.favorite.browse.subtitle",
                        imageName: App.DesignSystem.Icons.favorite
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    App.Home.Views.Home()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
