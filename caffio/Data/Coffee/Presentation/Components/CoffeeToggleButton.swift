import SwiftUI
import SwiftData

extension App.Coffee.Components {
    struct ToggleButton: View {
        let coffee: App.Coffee.Entities.Coffee
        @Environment(\.modelContext) private var modelContext

        private func toggleFavorite() {
            coffee.isFavorite.toggle()
            do {
                try modelContext.save()
            } catch {
                print("❌ Erreur sauvegarde favoris: \(error)")
            }
        }

        var body: some View {
            Button(action: toggleFavorite) {
                RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.xsmall)
                    .fill(.regularMaterial)
                    .frame(width: App.DesignSystem.Size.medium, height: App.DesignSystem.Size.medium)
                    .overlay {
                        Image(systemName: coffee.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(coffee.isFavorite ? .red : .secondary)
                            .font(.caption)
                    }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    App.Coffee.Components.ToggleButton(coffee: .complexMock)
        .modelContainer(for: [App.Coffee.Entities.Coffee.self], inMemory: true)
}
