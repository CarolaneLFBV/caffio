import SwiftUI
import SwiftData

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            App.Home.Views.Home()
        }
        .modelContainer(App.Core.Config.shared.container)
    }
}
