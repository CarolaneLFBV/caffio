import SwiftUI

extension App.Coffee.Components {
    struct Information: View {
        let coffee: App.Coffee.Entities.Coffee
        
        var body: some View {
            content
        }
        
        private var separator: some View {
            Rectangle()
                .foregroundColor(.secondary.opacity(0.3))
                .frame(width: 1, height: App.DesignSystem.Size.large)
        }
    }
}

private extension App.Coffee.Components.Information {
    var content: some View {
        HStack(alignment: .center, spacing: App.DesignSystem.Padding.component) {
            timeSection
            separator
            App.Coffee.Components.DifficultyTag(coffee: coffee)
            separator
            cupSection
        }
    }

    var timeSection: some View {
        VStack(spacing: App.DesignSystem.Padding.tight) {
            Image(systemName: App.DesignSystem.Icons.clock)
                .foregroundStyle(.primary)
            Text(coffee.preparationTimeFormatted)
                .foregroundStyle(.secondary)
        }
        .font(.caption)
    }

    var cupSection: some View {
        VStack(spacing: App.DesignSystem.Padding.tight) {
            Image(systemName: App.DesignSystem.Icons.coffee)
                .foregroundStyle(.primary)
            Text(coffee.glassType.displayName)
                .foregroundStyle(.secondary)
        }
        .font(.caption)
    }
}


#Preview {
    App.Coffee.Components.Information(coffee: App.Coffee.Entities.Coffee.complexMock)
}
