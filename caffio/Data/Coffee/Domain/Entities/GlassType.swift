import Foundation

extension App.Coffee.Entities {
    enum GlassType: String, CaseIterable, Codable {
        case cup = "cup"
        case mug = "mug"
        case glass = "glass"
        case tumbler = "tumbler"
        case frenchPress = "french_press"
        case chemex = "chemex"
        case v60 = "v60"

        var displayName: String {
            switch self {
            case .cup:
                return "Cup"
            case .mug:
                return "Mug"
            case .glass:
                return "Glass"
            case .tumbler:
                return "Tumbler"
            case .frenchPress:
                return "French PRess"
            case .chemex:
                return "Chemex"
            case .v60:
                return "V60"
            }
        }
    }
}
