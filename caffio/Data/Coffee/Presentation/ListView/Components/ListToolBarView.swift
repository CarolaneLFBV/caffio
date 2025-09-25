import SwiftUI

extension App.Coffee.Components {
    struct ToolBar: ToolbarContent {
        @Bindable var model: CoffeeListModel

        var body: some ToolbarContent {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Picker("app.sort", selection: $model.sortOption) {
                        ForEach(App.Coffee.Entities.Coffee.CoffeeSortDescriptor.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
        }
    }
}
