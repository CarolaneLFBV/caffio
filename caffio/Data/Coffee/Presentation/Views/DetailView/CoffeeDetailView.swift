import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct Detail: View {
        let coffee: App.Coffee.Entities.Coffee
        @Environment(\.modelContext) private var modelContext
        @Environment(\.dismiss) private var dismiss
        @State private var isVisible = false
        @State private var showDeleteAlert = false
        @State private var showEditSheet = false
        
        private var isFav: Bool {
            coffee.isFavorite
        }

        private func deleteCoffee() {
            modelContext.delete(coffee)
            do {
                try modelContext.save()
                dismiss()
            } catch {
                print("❌ Erreur suppression: \(error)")
            }
        }
        
        private func saveCoffee() {
            do {
                try modelContext.save()
            } catch {
                print("❌ Erreur sauvegarde: \(error)")
            }
        }

        private var coffeeTypeText: String {
            if coffee.coffeeType.isEmpty {
                return "No type specified"
            } else if coffee.coffeeType.count == 1 {
                return coffee.coffeeType.first?.displayName ?? ""
            } else {
                return coffee.coffeeType.map { $0.displayName }.joined(separator: " • ")
            }
        }
    }
}

// MARK: - Body
extension App.Coffee.Views.Detail {
    var body: some View {
        ScrollView {
            content
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Section {
                        ControlGroup {
                            Button("app.edit", systemImage: "pencil") {
                                showEditSheet = true
                            }

                            Button("app.delete", systemImage: "trash", role: .destructive) {
                                showDeleteAlert = true
                            }
                        }
                    }
                    
                    Section {
                        Button(
                            isFav ? "app.unfavorite" : "app.favorite",
                            systemImage: isFav ? "minus.circle" : "plus.circle"
                        ) {
                            coffee.isFavorite.toggle()
                            saveCoffee()
                        }
                    }
                } label: {
                    Image(systemName: App.DesignSystem.Icons.menu)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isVisible = true
            }
        }
        .sheet(isPresented: $showEditSheet) {
            App.Coffee.Views.Edit(coffee: coffee)
        }
        .alert("coffee.alert.delete.title", isPresented: $showDeleteAlert) {
            Button("app.cancel", role: .cancel) { }
            Button("app.delete", role: .destructive) {
                deleteCoffee()
            }
        } message: {
            Text("coffee.alert.delete.message")
        }
    }
}

// MARK: - Content Views
extension App.Coffee.Views.Detail {
    var content: some View {
        VStack(spacing: App.DesignSystem.Padding.section) {
            App.Coffee.Components.Header(coffee: coffee)
                .overlay(alignment: .bottom) {
                    header
                        .offset(y: isVisible ? -10 : 10)
                        .opacity(isVisible ? 1.0 : 0.0)
                }
            information
            ingredients
            instructions
        }
        .scaleEffect(isVisible ? 1.0 : 1.1)
        .opacity(isVisible ? 1.0 : 0.0)
    }

    var header: some View {
        VStack(spacing: App.DesignSystem.Padding.tight) {
            Text(coffee.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(coffeeTypeText)
                .font(.caption)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.center)
            Text(coffee.shortDescription)
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
    }

    var information: some View {
        App.Coffee.Components.Information(coffee: coffee)
    }

    var ingredients: some View {
        App.Ingredient.Views.List(ingredients: coffee.ingredients)
    }

    var instructions: some View {
        App.Coffee.Components.Instruction(coffee: coffee)
    }
}

#Preview {
    App.Coffee.Views.Detail(coffee: App.Coffee.Entities.Coffee.complexMock)
}
