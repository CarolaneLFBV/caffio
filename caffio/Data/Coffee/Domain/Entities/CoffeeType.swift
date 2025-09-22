import Foundation

extension App.Coffee.Entities {
    enum CoffeeType: String, CaseIterable, Codable {
        case hot = "hot"
        case cold = "cold"
        case short = "short"
        case long = "long"
        case iced = "iced"
        case filtered = "filtered"

        var displayName: String {
            switch self {
            case .hot:
                return "Hot"
            case .cold:
                return "Cold"
            case .short:
                return "Short"
            case .long:
                return "Long"
            case .iced:
                return "Iced"
            case .filtered:
                return "Filtered"
            }
        }
    }
}
