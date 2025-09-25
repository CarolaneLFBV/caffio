import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct GeneratedCoffeeSheet: View {
        let coffee: App.Coffee.AI.CoffeeGenerable
        let coffeeMaker: App.Coffee.AI.CoffeeMaker
        @Binding var isPresented: Bool
        @Binding var showSaveSuccess: Bool
        
        private var temporaryCoffeeEntity: App.Coffee.Entities.Coffee {
            coffee.toCoffeeEntity()
        }
        
        var body: some View {
            NavigationStack {
                Detail(coffee: temporaryCoffeeEntity)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(role: .cancel) {
                                coffeeMaker.clearGeneration()
                                isPresented = false
                            } label: {
                                Text("app.clear")
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(role: .confirm) {
                                coffeeMaker.saveCoffee()
                                showSaveSuccess = true
                                isPresented = false
                            } label: {
                                Text("app.save")
                            }
                        }
                    }
            }
        }
    }
}
