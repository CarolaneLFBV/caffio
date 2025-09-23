import SwiftUI

extension App.Core {
    struct Navigation: View {
        @State private var selectedIndex: Int = 0

        var body: some View {
            TabView(selection: $selectedIndex) {
                NavigationStack {
                    App.Home.Views.Home()
                }
                .tabItem {
                    Label("coffee.list", systemImage: "cup.and.heat.waves")
                }
                .tag(0)

            }
        }
    }
}
