import SwiftUI

extension App.Coffee.Components {
    struct Row: View {
        let coffee: App.Coffee.Entities.Coffee

        var body: some View {
            HStack(spacing: App.DesignSystem.Padding.component) {
                coffee.displayedImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: App.DesignSystem.Size.thumbnailMedium, height: App.DesignSystem.Size.thumbnailMedium)
                    .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.element))

                VStack(alignment: .leading, spacing: App.DesignSystem.Padding.tight) {
                    HStack {
                        Text(coffee.name)
                            .font(.headline)
                        Spacer()
                        App.Coffee.Components.DifficultyTag(coffee: coffee).stars
                    }

                    Text(coffee.shortDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)

                    HStack(spacing: App.DesignSystem.Padding.tight) {
                        Image(systemName: App.DesignSystem.Icons.clock)
                            .foregroundStyle(.secondary)
                        Text(coffee.preparationTimeFormatted)
                            .foregroundStyle(.secondary)
                    }
                    .font(.caption2)
                }
                Spacer()
            }
            .frame(height: App.DesignSystem.Size.coffeeRowHeight)
        }
    }
}

#Preview {
    App.Coffee.Components.Row(coffee: .complexMock)
}
