import SwiftUI

extension App.Coffee.Components {
    struct IntelligentButton: View {
        let boolInput: Bool
        
        var body: some View {
            Label("app.coffee.intelligence.generate", systemImage: App.DesignSystem.Icons.sparkles)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.textForeground)
                .padding(App.DesignSystem.Padding.medium)
                .background(.iconBackground, in: .rect(cornerRadius: App.DesignSystem.CornerRadius.small, style: .continuous))
        }
    }
}


#Preview {
    App.Coffee.Components.IntelligentButton(boolInput: true)
}
