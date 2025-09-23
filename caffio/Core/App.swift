//
//  caffioApp.swift
//  caffio
//
//  Created by Carolane Lefebvre on 22/09/2025.
//

import SwiftUI
import SwiftData

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            App.Core.Navigation()
        }
        .modelContainer(App.Core.Config.shared.container)
    }
}
