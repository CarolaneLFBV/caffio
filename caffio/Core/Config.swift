import SwiftData
import Foundation

extension App.Core {
    struct Config {
        static let shared = Config()
        
        var container: ModelContainer = {
            let schema = Schema([
                App.Coffee.Entities.Coffee.self,
                App.Ingredient.Entities.Ingredient.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(
                    for: schema, 
                    configurations: [modelConfiguration]
                )
            } catch {
                fatalError("Could not create ModelContainer: \(error.localizedDescription)")
            }
        }()
    }
}
