import SwiftUI

extension App.Coffee.Components {
    struct TypePicker<T: CaseIterable & Hashable & RawRepresentable>: View where T.RawValue == String {
        let imageTitle: String
        let pickerTitle: String
        @Binding var selection: T
        let onChange: (T) -> Void

        var body: some View {
            HStack(spacing: App.DesignSystem.Padding.medium) {
                App.DesignSystem.pickerImage(title: imageTitle)
                Picker(pickerTitle, selection: $selection) {
                    ForEach(Array(T.allCases), id: \.self) { option in
                        Text(option.rawValue.capitalized).tag(option)
                    }
                }
                .onChange(of: selection) { _, newValue in
                    onChange(newValue)
                }
            }
        }
    }
}
