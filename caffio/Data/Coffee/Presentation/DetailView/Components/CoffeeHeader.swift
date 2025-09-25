import SwiftUI

extension App.Coffee.Components {
    struct Header: View {
        let coffee: App.Coffee.Entities.Coffee
        
        var body: some View {
            coffee.displayedImage
                .resizable()
                .frame(height: App.DesignSystem.Size.imageHero)
                .scaledToFill()
                .mask {
                    Rectangle()
                        .fill(
                            Gradient(stops: [
                                .init(color: .white, location: 0.0),
                                .init(color: .white.opacity(0.8), location: 0.4),
                                .init(color: .clear, location: 1.0)
                            ])
                            .colorSpace(.perceptual)
                        )
                }
                .clipped()
        }
    }
}

#Preview {
    App.Coffee.Components.Header(coffee: App.Coffee.Entities.Coffee.complexMock)
}
