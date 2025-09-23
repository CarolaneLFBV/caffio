//
//  Padding.swift
//  caffio
//
//  Created by Carolane Lefebvre on 23/09/2025.
//

import Foundation

extension App.DesignSystem {
    enum Padding {
        // Base increments (4pt system)
        static let xsmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xlarge: CGFloat = 20
        static let xxlarge: CGFloat = 24

        // Extended sizes for special cases
        static let huge: CGFloat = 32
        static let massive: CGFloat = 48
        static let giant: CGFloat = 64

        // Semantic naming for specific use cases
        static let container: CGFloat = 16      // Main container padding
        static let section: CGFloat = 20        // Between sections
        static let component: CGFloat = 12      // Inside components
        static let element: CGFloat = 8         // Between small elements
        static let tight: CGFloat = 4           // Very close elements

        // Screen margins
        static let screenHorizontal: CGFloat = 16
        static let screenVertical: CGFloat = 20

        // Card and modal specific
        static let card: CGFloat = 16
        static let modal: CGFloat = 24
    }
}
