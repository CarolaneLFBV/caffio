import Foundation

extension App.Coffee.Protocols {
    protocol Storable {
        func fetchAll() throws -> [App.Coffee.Entities.Model]
        func fetchByID(_ id: UUID) throws -> App.Coffee.Entities.Model?
        func save(_ coffee: App.Coffee.Entities.Model) throws
        func delete(_ coffee: App.Coffee.Entities.Model) throws
        func importSampleDataIfNeeded() async throws
    }
}

