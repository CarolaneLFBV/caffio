import SwiftUI

extension App.DesignSystem.Components {
    struct HeaderMesh: View {
        @State private var animationPhase = 0.0

        var body: some View {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .darkBrown.opacity(0.8), .mediumBrown.opacity(0.7), .lightBrown.opacity(0.6),
                    .darkBrown.opacity(0.8), .mediumBrown.opacity(0.7), .lightBrown.opacity(0.8),
                    .darkBrown.opacity(0.8), .mediumBrown.opacity(0.8), .darkBrown.opacity(0.9)
                ]
            )
            .frame(height: 280)
            .frame(maxWidth: .infinity)
            .compositingGroup()
            .hueRotation(.degrees(animationPhase * 5))
            .onAppear {
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                    animationPhase = .pi * 2
                }
            }
            .mask {
                Rectangle()
                    .fill(
                        Gradient(stops: [
                            .init(color: .white, location: 0.3),
                            .init(color: .clear, location: 1.0)
                        ])
                        .colorSpace(.perceptual)
                    )
            }
        }
    }
}
