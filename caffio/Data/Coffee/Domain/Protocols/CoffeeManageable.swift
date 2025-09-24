import Foundation

/// For Repository
extension App.Coffee.Protocols {
    protocol Manageable {
        static func fetchAll() throws -> [App.Coffee.Entities.Coffee]
        static func fetchByID(_ id: UUID) throws -> App.Coffee.Entities.Coffee?
        static func save(_ coffee: App.Coffee.Entities.Coffee) throws
        static func delete(_ coffee: App.Coffee.Entities.Coffee) throws
    }
}

