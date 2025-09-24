//
//  CoffeeInstruction.swift
//  caffio
//
//  Created by Carolane Lefebvre on 23/09/2025.
//

import SwiftUI

extension App.Coffee.Components {
    struct Instruction: View {
        let coffee: App.Coffee.Entities.Coffee
        
        var body: some View {
            content
        }

        private func instructionRow(number: Int, text: String) -> some View {
            HStack(alignment: .top, spacing: App.DesignSystem.Padding.component) {
                Text("\(number)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.iconForeground)
                    .frame(width: App.DesignSystem.Size.instructionNumberSize, height: App.DesignSystem.Size.instructionNumberSize)
                    .background(.iconBackground)
                    .clipShape(Circle())

                Text(text)
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension App.Coffee.Components.Instruction {
    var content: some View {
        VStack(alignment: .leading, spacing: App.DesignSystem.Padding.component) {
            sectionTitle
            LazyVStack(spacing: App.DesignSystem.Padding.component) {
                ForEach(Array(coffee.instructions.enumerated()), id: \.offset) { index, instruction in
                    instructionRow(number: index + 1, text: instruction)
                }
            }
        }
        .padding(.horizontal, App.DesignSystem.Padding.screenHorizontal)
    }
    
    var sectionTitle: some View {
        Text("coffee.instructions")
            .font(.title2)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    App.Coffee.Components.Instruction(coffee: App.Coffee.Entities.Coffee.complexMock)
}
