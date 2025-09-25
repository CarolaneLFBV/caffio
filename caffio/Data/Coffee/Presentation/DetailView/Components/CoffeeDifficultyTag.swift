import SwiftUI

extension App.Coffee.Components.DifficultyTag {
    enum Constants {
        static let totalStars: Int = 3
        static let starSpacing: CGFloat = 2
    }
}

extension App.Coffee.Components {
    struct DifficultyTag: View {
        let coffee: App.Coffee.Entities.Coffee
        var body: some View {
            VStack(spacing: App.DesignSystem.Padding.tight) {
                stars
                text
            }
        }
    }
}

extension App.Coffee.Components.DifficultyTag {
    var stars: some View {
        HStack(spacing: Constants.starSpacing) {
            ForEach(0..<Constants.totalStars, id: \.self) { index in
                Image(systemName: index < coffee.difficultyStars ? App.DesignSystem.Icons.starFill : App.DesignSystem.Icons.star)
                    .foregroundStyle(.primary)
                    .font(.caption)
            }
        }
    }

    var text: some View {
        Text(coffee.difficulty.displayName)
            .foregroundColor(.secondary)
            .font(.caption2)
    }
}

#Preview {
    App.Coffee.Components.DifficultyTag(coffee: App.Coffee.Entities.Coffee.complexMock)
}
