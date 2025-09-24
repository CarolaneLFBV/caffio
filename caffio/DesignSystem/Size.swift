import Foundation

extension App.DesignSystem {
    enum Size {
        // MARK: - Base sizes (used in app)
        static let xsmall: CGFloat = 8
        static let medium: CGFloat = 24
        static let large: CGFloat = 48

        // MARK: - Icons (used in app)
        static let iconXSmall: CGFloat = 8
        static let iconSmall: CGFloat = 16
        static let iconMedium: CGFloat = 24
        static let iconLarge: CGFloat = 32
        static let iconHuge: CGFloat = 48

        // MARK: - Images & Thumbnails (used in app)
        static let thumbnailMedium: CGFloat = 60
        static let thumbnailHuge: CGFloat = 120
        static let imageCard: CGFloat = 200
        static let imageHero: CGFloat = 300

        // MARK: - Cards & Containers (used in app)
        static let cardMediumHeight: CGFloat = 200
        static let containerMedium: CGFloat = 120

        // MARK: - Coffee specific sizes (used in app)
        static let coffeeRowHeight: CGFloat = 80
        static let instructionNumberSize: CGFloat = 24
    }
}
