//
//  Utils.swift
//  caffio
//
//  Created by Carolane Lefebvre on 24/09/2025.
//

import Foundation

extension App.Core {
    final class Utils {
        // Struct pour matcher la structure JSON {"coffees": [...]}
        private struct CoffeeData: Codable {
            let coffees: [App.Coffee.Entities.Converted]
        }

        static func getCoffees() throws -> [App.Coffee.Entities.Converted] {
            guard let url = Bundle.main.url(forResource: "coffees", withExtension: "json") else {
                throw URLError(.badURL)
            }

            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(CoffeeData.self, from: data)
                return decodedData.coffees  // Extraire l'array des coffees
            } catch {
                print("❌ Caffio: JSON Parse Error: \(error)")
                throw URLError(.cannotParseResponse)
            }
        }
    }
}
