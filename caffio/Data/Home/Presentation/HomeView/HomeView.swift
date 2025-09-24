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
        @State private var showCoffeeMaker = false
        @State private var showCoffeeList = false
        @Environment(\.modelContext) private var modelContext

        var body: some View {
            NavigationStack {
                ScrollView {
                    content
                }
                .navigationTitle("app.name")
                .navigationDestination(item: $selectedCoffee) { coffee in
                    App.Coffee.Views.Detail(coffee: coffee)
                }
                .navigationDestination(isPresented: $showCoffeeMaker) {
                    App.Coffee.Views.CoffeeMaker()
                }
                .navigationDestination(isPresented: $showCoffeeList) {
                    App.Coffee.Views.List()
                }
            }
        }

        private func sectionHeader(_ title: String) -> some View {
            Text(title)
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
                sectionHeader("Popular Coffees")
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
        VStack(alignment: .leading) {
            sectionHeader("Need inspiration?")
            
            Button(action: {
                showCoffeeMaker = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component)
                        .fill(
                            LinearGradient(
                                colors: [.black, .brown, .gray],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: App.DesignSystem.Size.cardMediumHeight)

                    VStack(alignment: .leading, spacing: App.DesignSystem.Padding.element) {
                        HStack {
                            Image(systemName: "apple.intelligence")
                                .foregroundColor(.white)
                                .font(.title2)

                            Text("app.intelligence")
                                .foregroundColor(.white)
                                .font(.title3)
                                .fontWeight(.medium)

                            Spacer()
                        }

                        Text("app.intelligence.description")
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
    }

    var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            sectionHeader("Quick Actions")

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: App.DesignSystem.Padding.component) {
                App.Home.Components.QuickActionCard(
                    icon: App.DesignSystem.Icons.search,
                    title: "Browse All",
                    subtitle: "Explore coffee recipes",
                    action: {
                        showCoffeeList = true
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
