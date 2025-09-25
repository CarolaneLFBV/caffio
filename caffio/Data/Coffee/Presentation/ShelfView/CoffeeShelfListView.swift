import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct ShelfList: View {
        @Query(sort: \App.Coffee.Entities.Coffee.name)
        private var allCoffees: [App.Coffee.Entities.Coffee]
        @State private var selectedCoffee: App.Coffee.Entities.Coffee?
        
        private var favoriteCoffees: [App.Coffee.Entities.Coffee] {
            allCoffees.filter { $0.isFavorite }
        }
        
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

private extension App.Coffee.Views.ShelfList {
    var content: some View {
        Group {
            if favoriteCoffees.isEmpty {
                emptyStateView
            } else {
                coffeesList
            }
        }
    }
    
    var emptyStateView: some View {
        App.Core.Navigation.ContentUnavailable(
            systemImage: App.DesignSystem.Icons.favorite,
            title: "coffee.no.favorite.title",
            subtitle: "coffee.no.favorite.subtitle"
        )
    }
    
    var coffeesList: some View {
        List {
            ForEach(favoriteCoffees) { coffee in
                App.Coffee.Components.Row(coffee: coffee)
                    .onTapGesture {
                        selectedCoffee = coffee
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .padding(.vertical, App.DesignSystem.Padding.tight)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    App.Coffee.Views.ShelfList()
}
