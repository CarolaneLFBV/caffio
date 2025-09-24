import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct ShelfList: View {
        @Query(filter: #Predicate<App.Coffee.Entities.Coffee> { coffee in
            coffee.isFavorite
        })
        private var coffees: [App.Coffee.Entities.Coffee]
        @State private var selectedCoffee: App.Coffee.Entities.Coffee?
        
        var body: some View {
            NavigationStack {
                content
                    .navigationTitle("coffee.shelf")
                    .navigationDestination(item: $selectedCoffee) { coffee in
                        App.Coffee.Views.Detail(coffee: coffee)
                    }
            }
        }
    }
}

extension App.Coffee.Views.ShelfList {
    var content: some View {
        SwiftUI.List(coffees, id: \.id) { coffee in
            App.Coffee.Components.Row(coffee: coffee)
                .onTapGesture {
                    selectedCoffee = coffee
                }
        }
    }
}

#Preview {
    App.Coffee.Views.ShelfList()
}
