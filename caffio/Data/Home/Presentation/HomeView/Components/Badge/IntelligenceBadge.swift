import SwiftUI

extension App.Home.Components {
    struct IntelligenceBadge: View {
        @State private var animatedGradient: Bool = false
        @Namespace private var intelligentCoffeeMaker
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium)
                    .fill(
                        LinearGradient(
                            colors: [
                                App.DesignSystem.Colors.startPoint,
                                App.DesignSystem.Colors.mediumPoint,
                                App.DesignSystem.Colors.endPoint,
                            ],
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                    )
                    .hueRotation(.degrees(animatedGradient ? -30 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animatedGradient.toggle()
                        }
                    }
                    .frame(height: App.DesignSystem.Size.cardMediumHeight)

                VStack(alignment: .leading, spacing: App.DesignSystem.Padding.element) {
                    HStack {
                        Image(systemName: App.DesignSystem.Icons.intelligence)
                            .foregroundColor(.white)
                            .font(.title2)

                        Text("app.intelligence")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.medium)

                        Spacer()
                    }

                    Text("app.intelligence.description")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
                .padding(App.DesignSystem.Padding.large)
                .frame(maxWidth: .infinity, alignment: .leading)
                .matchedTransitionSource(id: "intelligence", in: intelligentCoffeeMaker)
            }
        }
    }

}

#Preview {
    App.Home.Components.IntelligenceBadge()
}
