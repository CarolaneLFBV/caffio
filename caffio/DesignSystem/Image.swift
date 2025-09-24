//
//  File.swift
//  caffio
//
//  Created by Carolane Lefebvre on 24/09/2025.
//

import SwiftUI

extension App.DesignSystem {
    static func pickerImage(title: String, system: Bool) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 29, height: 27)
            .foregroundStyle(.iconBackground)
            .overlay {
                if system {
                    Image(systemName: title)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 18)
                        .foregroundStyle(.iconForeground)
                } else {
                    Image(title)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 23, height: 23)
                        .foregroundStyle(.iconForeground)
                }
            }
    }
}
