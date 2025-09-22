import Foundation

extension App.Coffee.Entities {
    enum Difficulty: String, CaseIterable, Codable {
        case easy = "easy"
        case medium = "medium"
        case hard = "hard"

        var displayName: String {
            switch self {
            case .easy:
                return "Easy"
            case .medium:
                return "Medium"
            case .hard:
                return "Hard"
            }
        }
    }
}
