//
//  Icons.swift
//  caffio
//
//  Created by Carolane Lefebvre on 23/09/2025.
//

import Foundation

extension App.DesignSystem {
    enum Icons {
        // MARK: - Navigation & UI
        static let back = "chevron.left"
        static let forward = "chevron.right"
        static let close = "xmark"
        static let menu = "line.3.horizontal"
        static let more = "ellipsis"
        static let search = "magnifyingglass"
        static let filter = "line.3.horizontal.decrease"
        static let sort = "arrow.up.arrow.down"

        // MARK: - Actions
        static let add = "plus"
        static let edit = "pencil"
        static let delete = "trash"
        static let save = "checkmark"
        static let share = "square.and.arrow.up"
        static let favorite = "heart"
        static let favoriteFilled = "heart.fill"
        static let bookmark = "bookmark"
        static let bookmarkFilled = "bookmark.fill"

        // MARK: - Coffee & Kitchen
        static let coffee = "cup.and.saucer"
        static let coffeeFill = "cup.and.saucer.fill"
        static let espresso = "takeoutbag.and.cup.and.straw"
        static let mug = "mug"
        static let mugFill = "mug.fill"
        static let thermometer = "thermometer.medium"
        static let timer = "timer"
        static let scale = "scalemass"

        // MARK: - Time & Clock
        static let clock = "clock"
        static let clockFill = "clock.fill"
        static let stopwatch = "stopwatch"
        static let hourglass = "hourglass"

        // MARK: - Difficulty & Rating
        static let star = "star"
        static let starFill = "star.fill"
        static let starHalf = "star.leadinghalf.filled"
        static let flame = "flame"
        static let flameFill = "flame.fill"

        // MARK: - Types & Categories
        static let hot = "flame"
        static let cold = "snowflake"
        static let iced = "cube"
        static let filtered = "drop"
        static let steam = "smoke"

        // MARK: - Ingredients & Measurements
        static let drop = "drop"
        static let dropFill = "drop.fill"
        static let grain = "circle.fill"
        static let milk = "drop.triangle"
        static let sugar = "cube"
        static let spoon = "fork.knife"

        // MARK: - Interface Elements
        static let info = "info.circle"
        static let infoFill = "info.circle.fill"
        static let warning = "exclamationmark.triangle"
        static let warningFill = "exclamationmark.triangle.fill"
        static let success = "checkmark.circle"
        static let successFill = "checkmark.circle.fill"
        static let error = "xmark.circle"
        static let errorFill = "xmark.circle.fill"

        // MARK: - Lists & Organization
        static let list = "list.bullet"
        static let grid = "square.grid.2x2"
        static let folder = "folder"
        static let folderFill = "folder.fill"
        static let tag = "tag"
        static let tagFill = "tag.fill"

        // MARK: - Settings & Tools
        static let settings = "gearshape"
        static let settingsFill = "gearshape.fill"
        static let tool = "wrench"
        static let toolFill = "wrench.fill"
        static let help = "questionmark.circle"
        static let helpFill = "questionmark.circle.fill"

        // MARK: - Data & Sync
        static let download = "arrow.down.circle"
        static let upload = "arrow.up.circle"
        static let sync = "arrow.clockwise"
        static let cloud = "cloud"
        static let cloudFill = "cloud.fill"

        // MARK: - Coffee App Specific
        static let recipe = "doc.text"
        static let recipeFill = "doc.text.fill"
        static let instructions = "list.number"
        static let ingredients = "list.bullet.rectangle"
        static let preparation = "timer.square"
        static let difficulty = "chart.bar"
        static let glassType = "wineglass"
        static let temperature = "thermometer.variable"

        // MARK: - Glass Types
        static let glassCup = "cup.and.saucer"
        static let glassMug = "mug"
        static let glassWine = "wineglass"
        static let glassTumbler = "cylinder"
        static let glassFrenchPress = "cylinder.split.1x2"
        static let glassChemex = "flask"
        static let glassV60 = "triangle"
    }
}