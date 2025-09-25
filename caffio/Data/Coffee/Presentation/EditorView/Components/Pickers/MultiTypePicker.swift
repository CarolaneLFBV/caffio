import SwiftUI

private extension App.Coffee.Components.MultiTypePicker {
    enum Constants {
        static var lightOpacity: Double { 0.1 }
        static var mediumOpacity: Double { 0.3 }
    }
}

extension App.Coffee.Components {
    struct MultiTypePicker<T: CaseIterable & Hashable & RawRepresentable>: View where T.RawValue == String {
        let imageTitle: String
        let sectionTitle: LocalizedStringKey
        @Binding var selections: [T]
        let onChange: ([T]) -> Void
        
        var body: some View {
            VStack(spacing: App.DesignSystem.Padding.tight) {
                HStack(spacing: App.DesignSystem.Padding.medium) {
                    App.DesignSystem.pickerImage(title: imageTitle)
                    Text(sectionTitle)
                    Spacer()
                }

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: App.DesignSystem.Padding.tight) {
                    ForEach(Array(T.allCases), id: \.self) { option in
                        HStack(spacing: App.DesignSystem.Padding.tight) {
                            Image(systemName: selections.contains(option) ? App.DesignSystem.Icons.check : App.DesignSystem.Icons.uncheck)
                                .foregroundColor(selections.contains(option) ? .primary : .secondary)
                                .font(.caption)

                            Text(option.rawValue.capitalized)
                                .font(.caption)
                                .lineLimit(1)

                            Spacer(minLength: 0)
                        }
                        .padding(.vertical, App.DesignSystem.Padding.tight)
                        .padding(.horizontal, App.DesignSystem.Padding.element)
                        .background(
                            RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.xsmall)
                                .fill(selections.contains(option) ? .primary.opacity(Constants.lightOpacity) : Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.xsmall)
                                .stroke(selections.contains(option) ? .primary.opacity(Constants.mediumOpacity) : Color.secondary.opacity(Constants.mediumOpacity), lineWidth: 1)
                        )
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleSelection(option)
                        }
                    }
                }
            }
        }
        
        private func toggleSelection(_ option: T) {
            if selections.contains(option) {
                selections.removeAll { $0 == option }
            } else {
                selections.append(option)
            }
            onChange(selections)
        }
    }
}

