import SwiftUI
import Foundation

extension App.Ingredient.Entities {
    struct Converted: Codable {
        let name: String
        let measure: Double
        let units: String
    }
}
