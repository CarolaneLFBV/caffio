import SwiftData
import Foundation

extension App.Coffee.Entities.Coffee {
    enum CoffeeSortDescriptor: String, CaseIterable {
        case name = "Name"
        case difficulty = "Difficulty"
        case glass = "Glass"
        
        func sortDescriptor(reversed: Bool) -> [SortDescriptor<App.Coffee.Entities.Coffee>] {
            let order: SortOrder = reversed ? .reverse : .forward
            return switch self {
            case .name:
                [SortDescriptor(\App.Coffee.Entities.Coffee.name, order: order)]
            case .difficulty:
                [SortDescriptor(\App.Coffee.Entities.Coffee.difficultyValue, order: order),
                 SortDescriptor(\App.Coffee.Entities.Coffee.name, order: .forward)]
            case .glass:
                [SortDescriptor(\App.Coffee.Entities.Coffee.glassValue, order: order),
                 SortDescriptor(\App.Coffee.Entities.Coffee.name, order: .forward)]
            }
        }
    }
}
