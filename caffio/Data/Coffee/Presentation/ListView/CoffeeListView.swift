import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct List: View {
        @Query private var coffees: [App.Coffee.Entities.Coffee]
        @State private var selectedCoffee: App.Coffee.Entities.Coffee?
        @State private var model: CoffeeListModel
        @State private var searchTerms: String = ""

        init() {
            let model = CoffeeListModel()
            self._model = State(initialValue: model)
            self._coffees = Query(model.coffeeDescriptor)
        }

        private var filteredCoffees: [App.Coffee.Entities.Coffee] {
            if searchTerms.isEmpty {
                return coffees
            } else {
                return coffees.filter { coffee in
                    coffee.name.localizedCaseInsensitiveContains(searchTerms) ||
                    coffee.shortDescription.localizedCaseInsensitiveContains(searchTerms)
                }
            }
        }

        var body: some View {
            NavigationStack {
                content
                    .navigationTitle("coffee.your.list")
                    .navigationDestination(item: $selectedCoffee) { coffee in
                        App.Coffee.Views.Detail(coffee: coffee)
                    }
                    .searchable(text: $searchTerms)
            }
        }
    }
}

extension App.Coffee.Views.List {
    var content: some View {
        SwiftUI.List(filteredCoffees, id: \.id) { coffee in
            App.Coffee.Components.Row(coffee: coffee)
                .onTapGesture {
                    selectedCoffee = coffee
                }
        }
        .listStyle(.plain)
        .listSectionIndexVisibility(.visible)
    }
}

#Preview {
    App.Coffee.Views.List()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
