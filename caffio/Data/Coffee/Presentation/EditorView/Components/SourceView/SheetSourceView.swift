import SwiftUI
import PhotosUI

extension App.Coffee.Components {
    struct SourceSheet: View {
        @Environment(\.dismiss) private var dismiss
        let onCameraSelected: () -> Void
        let onPhotoLibrarySelected: () -> Void

        var body: some View {
            content
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.hidden)
        }
        
        private func buttonStyle(imageName: String, title: LocalizedStringKey, subtitle: LocalizedStringKey) -> some View {
            HStack(spacing: App.DesignSystem.Padding.medium) {
                Image(systemName: imageName)
                    .font(.title2)
                    .frame(width: App.DesignSystem.Size.iconLarge)

                VStack(alignment: .leading, spacing: App.DesignSystem.Padding.tight) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(App.DesignSystem.Padding.large)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium))
        }
    }
}

private extension App.Coffee.Components.SourceSheet {
    var content: some View {
        VStack {
            RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.xsmall)
                .fill(Color(.systemGray4))
                .frame(width: App.DesignSystem.Size.large, height: App.DesignSystem.Size.xsmall)
                .padding(.top, App.DesignSystem.Padding.element)

            VStack(spacing: App.DesignSystem.Padding.large) {
                // Select Photo Source
                Text("app.photo.source")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, App.DesignSystem.Padding.large)

                VStack(spacing: App.DesignSystem.Padding.component) {
                    Button(action: {
                        onCameraSelected()
                        dismiss()
                    }) {
                        buttonStyle(
                            imageName: "camera.fill",
                            title: "app.camera",
                            subtitle: "app.camera.subtitle"
                        )
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        onPhotoLibrarySelected()
                        dismiss()
                    }) {
                        buttonStyle(
                            imageName: "photo.fill",
                            title: "app.library",
                            subtitle: "app.library.subtitle"
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, App.DesignSystem.Padding.large)

                Button("app.cancel") {
                    dismiss()
                }
                .font(.headline)
                .foregroundColor(.red)
                .padding(.bottom, App.DesignSystem.Padding.large)
            }
        }
    }
}

#Preview {
    App.Coffee.Components.SourceSheet(
        onCameraSelected: { print("Camera selected") },
        onPhotoLibrarySelected: { print("Photo library selected") }
    )
}
