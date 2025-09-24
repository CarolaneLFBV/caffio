import SwiftUI
import SwiftData

extension App.Coffee.Views {
    struct Edit: View {
        let coffee: App.Coffee.Entities.Coffee
        @Environment(\.modelContext) private var modelContext
        @Environment(\.dismiss) private var dismiss
        @State private var editingName = ""
        @State private var editingDescription = ""
        @State private var editingDifficulty: App.Coffee.Entities.Difficulty = .easy
        @State private var editingTime = 0
        @State private var editingGlassType: App.Coffee.Entities.GlassType = .cup
        @State private var editingCoffeeTypes: [App.Coffee.Entities.CoffeeType] = []
        @State private var editingInstructions: [String] = []

        private func toggleCoffeeType(_ type: App.Coffee.Entities.CoffeeType) {
            if editingCoffeeTypes.contains(type) {
                editingCoffeeTypes.removeAll { $0 == type }
            } else {
                editingCoffeeTypes.append(type)
            }
        }

        private func removeInstruction(at offsets: IndexSet) {
            editingInstructions.remove(atOffsets: offsets)
        }

        private func loadCoffeeData() {
            editingName = coffee.name
            editingDescription = coffee.shortDescription
            editingDifficulty = coffee.difficulty
            editingTime = coffee.preparationTimeMinutes
            editingGlassType = coffee.glassType
            editingCoffeeTypes = coffee.coffeeType
            editingInstructions = coffee.instructions
        }

        private func saveCoffee() {
            coffee.name = editingName.trimmingCharacters(in: .whitespacesAndNewlines)
            coffee.shortDescription = editingDescription.trimmingCharacters(in: .whitespacesAndNewlines)
            coffee.difficulty = editingDifficulty
            coffee.preparationTimeMinutes = editingTime
            coffee.glassType = editingGlassType
            coffee.coffeeType = editingCoffeeTypes
            coffee.instructions = editingInstructions.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

            do {
                try modelContext.save()
                dismiss()
            } catch {
                print("❌ Erreur sauvegarde: \(error)")
            }
        }
    }
}

// MARK: - Body
extension App.Coffee.Views.Edit {
    var body: some View {
        NavigationStack {
            Form {
                basicInfoSection
                coffeeOptionsSection
                instructionsSection
            }
            .navigationTitle("app.edit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("app.cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("app.save") {
                        saveCoffee()
                    }
                    .fontWeight(.semibold)
                    .disabled(editingName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .onAppear {
                loadCoffeeData()
            }
        }
    }
}

// MARK: - Form Sections
extension App.Coffee.Views.Edit {
    var basicInfoSection: some View {
        Section("coffee.section.informations") {
            TextField("coffee.name", text: $editingName)
                .autocorrectionDisabled()

            TextField("coffee.description", text: $editingDescription, axis: .vertical)
                .lineLimit(2...4)

            HStack {
                Text("coffee.preparation.time")
                Spacer()
                TextField("coffee.preparation.time.minutes", value: $editingTime, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 80)
                Text("coffee.preparation.time.min")
                    .foregroundStyle(.secondary)
            }
        }
    }

    var coffeeOptionsSection: some View {
        Section("coffee.options") {
            App.Coffee.Components.TypePicker(
                imageTitle: "star.fill",
                pickerTitle: "Difficulty",
                selection: $editingDifficulty,
                onChange: { newValue in
                    editingDifficulty = newValue
                }
            )
            App.Coffee.Components.TypePicker(
                imageTitle: "cup.and.saucer.fill",
                pickerTitle: "Type of Glass",
                selection: $editingGlassType,
                onChange: { newValue in
                    editingGlassType = newValue
                }
            )
            App.Coffee.Components.MultiTypePicker(
                imageTitle: "cup.and.heat.waves.fill",
                sectionTitle: "Types",
                selections: $editingCoffeeTypes,
                onChange: { newSelections in
                    editingCoffeeTypes = newSelections
                }
            )
        }
    }

    var instructionsSection: some View {
        Section {
            ForEach(Array(editingInstructions.enumerated()), id: \.offset) { index, instruction in
                HStack {
                    Text("\(index + 1).")
                        .foregroundStyle(.secondary)
                        .frame(width: 20, alignment: .leading)

                    TextField("Step \(index + 1)", text: Binding(
                        get: { editingInstructions[index] },
                        set: { editingInstructions[index] = $0 }
                    ), axis: .vertical)
                    .lineLimit(1...3)
                }
            }
            .onDelete(perform: removeInstruction)

            Button("coffee.instruction.add") {
                editingInstructions.append("")
            }
            .foregroundColor(.accentColor)
        } header: {
            Text("coffee.instructions")
        } footer: {
            if editingInstructions.isEmpty {
                Text("coffee.no.instructions")
            }
        }
    }
}

#Preview {
    App.Coffee.Views.Edit(coffee: App.Coffee.Entities.Coffee.complexMock)
        .modelContainer(for: [App.Coffee.Entities.Coffee.self], inMemory: true)
}
