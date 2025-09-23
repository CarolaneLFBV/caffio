import Foundation

extension App.DesignSystem {
    enum Size {
        // MARK: - Base sizes (4pt system)
        static let tiny: CGFloat = 16
        static let xsmall: CGFloat = 8
        static let small: CGFloat = 24
        static let medium: CGFloat = 32
        static let large: CGFloat = 48
        static let xlarge: CGFloat = 64
        static let xxlarge: CGFloat = 80
        static let huge: CGFloat = 120
        static let massive: CGFloat = 160
        static let giant: CGFloat = 200

        // MARK: - Icons & Buttons
        static let iconSmall: CGFloat = 16
        static let iconMedium: CGFloat = 24
        static let iconLarge: CGFloat = 32
        static let iconHuge: CGFloat = 48

        static let buttonHeight: CGFloat = 44
        static let buttonHeightSmall: CGFloat = 32
        static let buttonHeightLarge: CGFloat = 56

        // MARK: - Images & Thumbnails
        static let thumbnailSmall: CGFloat = 40
        static let thumbnailMedium: CGFloat = 60
        static let thumbnailLarge: CGFloat = 80
        static let thumbnailHuge: CGFloat = 120

        static let imageCard: CGFloat = 200
        static let imageHero: CGFloat = 300
        static let imageFull: CGFloat = 400

        // MARK: - Avatars & Profiles
        static let avatarSmall: CGFloat = 32
        static let avatarMedium: CGFloat = 48
        static let avatarLarge: CGFloat = 64
        static let avatarHuge: CGFloat = 96

        // MARK: - Cards & Containers
        static let cardMinHeight: CGFloat = 120
        static let cardMediumHeight: CGFloat = 200
        static let cardLargeHeight: CGFloat = 280

        static let containerSmall: CGFloat = 80
        static let containerMedium: CGFloat = 120
        static let containerLarge: CGFloat = 200

        // MARK: - Navigation & Bars
        static let navigationBarHeight: CGFloat = 44
        static let tabBarHeight: CGFloat = 49
        static let toolbarHeight: CGFloat = 44

        // MARK: - Modal & Sheet
        static let modalMaxWidth: CGFloat = 600
        static let modalMaxHeight: CGFloat = 800
        static let sheetCornerRadius: CGFloat = 12

        // MARK: - List & Table
        static let listRowHeight: CGFloat = 44
        static let listRowHeightLarge: CGFloat = 60
        static let listRowHeightHuge: CGFloat = 80

        // MARK: - Input & Form
        static let inputHeight: CGFloat = 44
        static let inputHeightLarge: CGFloat = 56
        static let textFieldMinHeight: CGFloat = 100

        // MARK: - Badges & Tags
        static let badgeSize: CGFloat = 20
        static let tagHeight: CGFloat = 28
        static let pillHeight: CGFloat = 32

        // MARK: - Coffee specific sizes
        static let coffeeImageCard: CGFloat = 180
        static let coffeeImageDetail: CGFloat = 250
        static let coffeeRowHeight: CGFloat = 80
        static let difficultyStarSize: CGFloat = 16
        static let instructionNumberSize: CGFloat = 24
    }
}
