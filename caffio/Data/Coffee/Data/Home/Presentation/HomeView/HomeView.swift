//
//  HomeView.swift
//  caffio
//
//  Created by Carolane Lefebvre on 23/09/2025.
//

import SwiftUI
import SwiftData

extension App.Home.Views {
    struct Home: View {
        @Query(sort: \App.Coffee.Entities.Coffee.name)
        private var coffees: [App.Coffee.Entities.Coffee]

        @State private var selectedCoffee: App.Coffee.Entities.Coffee?
        @Environment(\.modelContext) private var modelContext

        var body: some View {
            NavigationStack {
                ScrollView {
                    content
                }
                .navigationTitle("Caffio")
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
                Text("Popular Coffees")
                    .font(.title2)
                    .fontWeight(.semibold)

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
                        App.Coffee.Components.Card(coffee: coffee) {
                            selectedCoffee = coffee
                        }
                    }
                }
                .padding(.horizontal, App.DesignSystem.Padding.tight)
            }
        }
    }

    var appleIntelligenceSection: some View {
        Button(action: {
            // Action pour Apple Intelligence
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component)
                    .fill(
                        LinearGradient(
                            colors: [.purple, .blue, .pink],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: App.DesignSystem.Size.cardMediumHeight)

                VStack(alignment: .leading, spacing: App.DesignSystem.Padding.element) {
                    HStack {
                        Image(systemName: App.DesignSystem.Icons.star)
                            .foregroundColor(.white)
                            .font(.title2)

                        Text("Intelligence")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.medium)

                        Spacer()
                    }

                    Text("Ask for a\nCoffee idea")
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

    var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            Text("Quick Actions")
                .font(.title2)
                .fontWeight(.semibold)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: App.DesignSystem.Padding.component) {
                App.Home.Components.QuickActionCard(
                    icon: App.DesignSystem.Icons.search,
                    title: "Browse All",
                    subtitle: "Explore coffee recipes",
                    action: {
                        // Navigation vers la liste complète
                    }
                )

                App.Home.Components.QuickActionCard(
                    icon: App.DesignSystem.Icons.difficulty,
                    title: "By Difficulty",
                    subtitle: "Filter by skill level",
                    action: {
                        // Navigation vers filtres
                    }
                )

                App.Home.Components.QuickActionCard(
                    icon: App.DesignSystem.Icons.timer,
                    title: "Quick Brews",
                    subtitle: "Under 5 minutes",
                    action: {
                        // Navigation vers cafés rapides
                    }
                )

                App.Home.Components.QuickActionCard(
                    icon: App.DesignSystem.Icons.favorite,
                    title: "Favorites",
                    subtitle: "Your saved recipes",
                    action: {
                        // Navigation vers favoris
                    }
                )
            }
        }
    }
}

#Preview {
    App.Home.Views.Home()
        .modelContainer(for: [App.Coffee.Entities.Coffee.self, App.Ingredient.Entities.Ingredient.self], inMemory: true)
}
