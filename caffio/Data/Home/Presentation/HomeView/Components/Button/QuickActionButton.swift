import SwiftUI

extension App.Home.Components {
    struct QuickActionButton: View {
        let title: LocalizedStringKey
        let subtitle: LocalizedStringKey
        let imageName: String
        
        var body: some View {
            VStack(spacing: App.DesignSystem.Padding.element) {
                Image(systemName: imageName)
                    .font(.system(size: App.DesignSystem.Size.iconLarge))

                VStack(spacing: App.DesignSystem.Padding.tight) {
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(App.DesignSystem.Padding.large)
            .frame(maxWidth: .infinity)
            .frame(height: App.DesignSystem.Size.containerMedium)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium))
        }
    }
}

#Preview {
    App.Home.Components.QuickActionButton(title: "Browse Favorites", subtitle: "Find your favorite podcasts here", imageName: "star")
}
