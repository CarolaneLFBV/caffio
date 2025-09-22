import Foundation

extension App.Coffee.Protocols {
    protocol Storable {
        func fetchAll() throws -> [App.Coffee.Entities.Coffee]
        func fetchByID(_ id: UUID) throws -> App.Coffee.Entities.Coffee?
        func save(_ coffee: App.Coffee.Entities.Coffee) throws
        func delete(_ coffee: App.Coffee.Entities.Coffee) throws
        func importSampleDataIfNeeded() async throws
    }
}

