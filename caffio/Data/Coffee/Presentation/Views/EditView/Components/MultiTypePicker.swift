import SwiftUI

extension App.Coffee.Components {
    struct MultiTypePicker<T: CaseIterable & Hashable & RawRepresentable>: View where T.RawValue == String {
        let imageTitle: String
        let system: Bool
        let sectionTitle: String
        @Binding var selections: [T]
        let onChange: ([T]) -> Void
        
        var body: some View {
            VStack(spacing: App.DesignSystem.Padding.medium) {
                HStack(spacing: App.DesignSystem.Padding.medium) {
                    App.DesignSystem.pickerImage(title: imageTitle, system: system)
                    Text(sectionTitle)
                        .font(.headline)
                    Spacer()
                }
                
                ForEach(Array(T.allCases), id: \.self) { option in
                    HStack {
                        Text(option.rawValue.capitalized)
                        Spacer()
                        Image(systemName: selections.contains(option) ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selections.contains(option) ? .primary : .secondary)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleSelection(option)
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


