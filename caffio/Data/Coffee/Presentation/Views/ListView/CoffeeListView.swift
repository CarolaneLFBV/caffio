import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct List: View {
        @Query(sort: \App.Coffee.Entities.Coffee.name)
        private var coffees: [App.Coffee.Entities.Coffee]
        
        @State private var selectedCoffee: App.Coffee.Entities.Coffee?

        @Environment(\.modelContext) private var modelContext

        var body: some View {
            NavigationStack {
                content
                    .navigationTitle("app.name")
                    .navigationDestination(item: $selectedCoffee) { coffee in
                        App.Coffee.Views.Detail(coffee: coffee)
                    }
                    .task {
                        await importDataIfNeeded()
                    }
            }
        }

        private func importDataIfNeeded() async {
            do {
                let persistence = App.Coffee.Persistence.Persistence(modelContext: modelContext)
                try await persistence.importSampleDataIfNeeded()
            } catch {
                print("❌ Failed to import sample data: \(error)")
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
    }
}

#Preview {
    App.Coffee.Views.List()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
