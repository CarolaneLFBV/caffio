import Foundation
import SwiftData
import Observation

@Observable
final class CoffeeListModel {
    var sortOption: App.Coffee.Entities.Coffee.CoffeeSortDescriptor = .name
    var isReversed: Bool = false

    var coffeeDescriptor: FetchDescriptor<App.Coffee.Entities.Coffee> {
        FetchDescriptor(
            sortBy: sortOption.sortDescriptor(reversed: isReversed)
        )
    }
}