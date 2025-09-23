import SwiftUI

extension App.Coffee.Components {
    struct Card: View {
        let coffee: App.Coffee.Entities.Coffee
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                VStack(alignment: .leading, spacing: App.DesignSystem.Padding.element) {
                    coffee.displayedImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: App.DesignSystem.Size.imageCard, height: App.DesignSystem.Size.thumbnailHuge)
                        .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component))

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
        }
    }
}

#Preview {
    App.Coffee.Components.Card(coffee: App.Coffee.Entities.Coffee.complexMock, action: {})
}
