import SwiftUI

extension App.Core.Navigation {
    struct ContentUnavailable: View {
        let systemImage: String
        let title: LocalizedStringKey
        let subtitle: LocalizedStringKey
        
        var body: some View {
            VStack(spacing: App.DesignSystem.Padding.large) {
                Image(systemName: systemImage)
                    .font(.system(size: App.DesignSystem.Size.iconHuge))
                    .foregroundColor(.secondary)
                
                VStack(spacing: App.DesignSystem.Padding.tight) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, App.DesignSystem.Padding.large)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.small))
        }
    }
}
