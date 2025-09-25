import SwiftUI

extension App.Coffee.Components {
    struct Card: View {
        let coffee: App.Coffee.Entities.Coffee
        let action: () -> Void
        let namespace: Namespace.ID

        var body: some View {
            Button(action: action) {
                VStack(alignment: .leading, spacing: App.DesignSystem.Padding.element) {
                    ZStack(alignment: .topTrailing) {
                        coffee.displayedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: App.DesignSystem.Size.imageCard, height: App.DesignSystem.Size.thumbnailHuge)
                            .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium))

                        App.DesignSystem.Components.FavoriteButton(coffee: coffee)
                            .offset(x: -6, y: 6)
                    }

                    VStack(alignment: .leading, spacing: App.DesignSystem.Padding.tight) {
                        Text(coffee.name)
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        Text(coffee.shortDescription)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        HStack {
                            App.Coffee.Components.DifficultyTag(coffee: coffee).stars

                            Spacer()

                            HStack(spacing: App.DesignSystem.Padding.tight) {
                                Image(systemName: App.DesignSystem.Icons.clock)
                                    .foregroundStyle(.secondary)
                                Text(coffee.preparationTimeFormatted)
                                    .foregroundStyle(.secondary)
                            }
                            .font(.caption)
                        }
                    }
                }
                .frame(width: App.DesignSystem.Size.imageCard)
            }
            .buttonStyle(PlainButtonStyle())
            .matchedTransitionSource(id: coffee.id, in: namespace)
        }
    }
}

#Preview {
    @Previewable @Namespace var namespace
    return App.Coffee.Components.Card(
        coffee: App.Coffee.Entities.Coffee.complexMock,
        action: {},
        namespace: namespace
    )
}
