import SwiftUI

extension App.DesignSystem {
    static func pickerImage(title: String) -> some View {
        RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.xsmall)
            .frame(width: App.DesignSystem.Size.iconMedium, height: App.DesignSystem.Size.iconMedium)
            .foregroundStyle(.iconBackground)
            .overlay {
                Image(systemName: title)
                    .resizable()
                    .scaledToFit()
                    .frame(height: App.DesignSystem.Size.iconSmall)
                    .foregroundStyle(.iconForeground)
            }
    }
}
