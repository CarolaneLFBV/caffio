import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct List: View {
        @Query(sort: \App.Coffee.Entities.Coffee.name)
        private var coffees: [App.Coffee.Entities.Coffee]

        @Environment(\.modelContext) private var modelContext

        var body: some View {
            NavigationStack {
                SwiftUI.List(coffees, id: \.id) { coffee in
                    CoffeeRow(coffee: coffee)
                }
                .navigationTitle("Caffio")
                .listStyle(.plain)
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

extension App.Coffee.Views {
    struct CoffeeRow: View {
        let coffee: App.Coffee.Entities.Coffee

        var body: some View {
            HStack {
                coffee.displayedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 4) {
                    Text(coffee.name)
                        .font(.headline)

                    Text(coffee.shortDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)

                    HStack {
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.caption2)
                            Text(coffee.preparationTimeFormatted)
                                .font(.caption2)
                        }

                        Spacer()

                        Text(coffee.difficulty.displayName)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(coffee.difficultyColor.opacity(0.2))
                            .foregroundColor(coffee.difficultyColor)
                            .clipShape(Capsule())
                    }
                }

                Spacer()
            }
        }
    }
}

#Preview {
    App.Coffee.Views.List()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
