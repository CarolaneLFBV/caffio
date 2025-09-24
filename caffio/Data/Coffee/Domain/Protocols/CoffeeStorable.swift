import Foundation

/// For Persistence
extension App.Coffee.Protocols {
    protocol Storable {
        static func fetchAll() throws -> [App.Coffee.Entities.Coffee]
        static func fetchByID(_ id: UUID) throws -> App.Coffee.Entities.Coffee?
        static func getOrCreate(_ coffee: App.Coffee.Entities.Coffee) throws -> App.Coffee.Entities.Coffee
        static func delete(_ coffee: App.Coffee.Entities.Coffee) throws
    }
}

