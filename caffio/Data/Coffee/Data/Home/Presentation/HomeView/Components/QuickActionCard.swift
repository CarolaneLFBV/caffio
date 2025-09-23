import SwiftUI

extension App.Home.Components {
    struct QuickActionCard: View {
        let icon: String
        let title: String
        let subtitle: String
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                VStack(spacing: App.DesignSystem.Padding.component) {
                    Image(systemName: icon)
                        .font(.system(size: App.DesignSystem.Size.iconLarge))
                        .foregroundStyle(.primary)

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
                .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.Padding.component))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
