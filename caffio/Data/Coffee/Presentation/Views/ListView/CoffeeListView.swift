import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct List: View {
        @Query(sort: \App.Coffee.Entities.Coffee.name)
        private var coffees: [App.Coffee.Entities.Coffee]
        @State private var selectedCoffee: App.Coffee.Entities.Coffee?

        var body: some View {
            NavigationStack {
                content
                    .navigationTitle("app.name")
                    .navigationDestination(item: $selectedCoffee) { coffee in
                        App.Coffee.Views.Detail(coffee: coffee)
                    }
            }
        }
    }
}

extension App.Coffee.Views.List {
    var content: some View {
        SwiftUI.List(coffees, id: \.id) { coffee in
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
