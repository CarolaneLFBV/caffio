import SwiftUI
import SwiftData

extension App.Coffee.Views.Editor {
    enum Mode {
        case create
        case edit(App.Coffee.Entities.Coffee)

        var title: LocalizedStringKey {
            switch self {
            case .create: return "coffee.new"
            case .edit: return "app.edit"
            }
        }

        var saveButtonTitle: LocalizedStringKey {
            switch self {
            case .create: return "app.save"
            case .edit: return "app.save"
            }
        }
        
        var isCreateMode: Bool {
            if case .create = self { return true }
            return false
        }
    }

}

extension App.Coffee.Views {
    struct Editor: View {
        @Environment(\.modelContext) private var modelContext
        @Environment(\.dismiss) private var dismiss
        let mode: Mode

        @State private var name: String = ""
        @State private var shortDescription: String = ""
        @State private var preparationTimeMinutes: Int = 5
        @State private var difficulty: App.Coffee.Entities.Difficulty = .easy
        @State private var glassType: App.Coffee.Entities.GlassType = .cup
        @State private var coffeeTypes: Set<App.Coffee.Entities.CoffeeType> = []
        @State private var instructions: [String] = [""]

        @State private var showSourceSheet = false
        @State private var showCamera = false
        @State private var showPhotoLibrary = false
        @State private var selectedImage: UIImage?

        @State private var showSaveAlert = false

        private var canSave: Bool {
            !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }

        init(mode: Mode = .create) {
            self.mode = mode
        }

        init(coffee: App.Coffee.Entities.Coffee) {
            self.mode = .edit(coffee)
        }
    
        private func loadData() {
            switch mode {
            case .create:
                break
            case .edit(let coffee):
                name = coffee.name
                shortDescription = coffee.shortDescription
                difficulty = coffee.difficulty
                preparationTimeMinutes = coffee.preparationTimeMinutes
                glassType = coffee.glassType
                coffeeTypes = Set(coffee.coffeeType)
                instructions = coffee.instructions.isEmpty ? [""] : coffee.instructions

                if let imageData = coffee.imageData {
                    selectedImage = UIImage(data: imageData)
                }
            }
        }

        private func saveCoffee() {
            switch mode {
            case .create:
                let newCoffee = App.Coffee.Entities.Coffee(
                    name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                    shortDescription: shortDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
                        "Custom coffee recipe" : shortDescription.trimmingCharacters(in: .whitespacesAndNewlines),
                    difficulty: difficulty,
                    preparationTimeMinutes: preparationTimeMinutes,
                    glassType: glassType,
                    coffeeType: Array(coffeeTypes),
                    instructions: instructions.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                )

                if let selectedImage = selectedImage {
                    newCoffee.imageData = selectedImage.jpegData(compressionQuality: 0.8)
                }

                modelContext.insert(newCoffee)

            case .edit(let coffee):
                coffee.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
                coffee.shortDescription = shortDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                coffee.difficulty = difficulty
                coffee.preparationTimeMinutes = preparationTimeMinutes
                coffee.glassType = glassType
                coffee.coffeeType = Array(coffeeTypes)
                coffee.instructions = instructions.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

                if let selectedImage = selectedImage {
                    coffee.imageData = selectedImage.jpegData(compressionQuality: 0.8)
                }
            }

            do {
                try modelContext.save()
                switch mode {
                case .create:
                    showSaveAlert = true
                case .edit:
                    dismiss()
                }
            } catch {
                print("❌ Erreur sauvegarde: \(error)")
            }
        }

        private func removeInstruction(at offsets: IndexSet) {
            instructions.remove(atOffsets: offsets)
        }
    }
}

// MARK: - Body
extension App.Coffee.Views.Editor {
    var body: some View {
        NavigationStack {
            Form {
                imageSection
                basicInformationSection
                optionsSection
                instructionsSection
            }
            .navigationTitle(mode.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("app.cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(mode.saveButtonTitle) {
                        saveCoffee()
                    }
                    .fontWeight(.semibold)
                    .disabled(!canSave)
                }
            }
            .onAppear {
                loadData()
            }
            .alert("coffee.alert.saved.title", isPresented: $showSaveAlert) {
                Button("app.ok", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("coffee.alert.saved.message")
            }
            .sheet(isPresented: $showSourceSheet) {
                App.Coffee.Components.SourceSheet(
                    onCameraSelected: {
                        showCamera = true
                    },
                    onPhotoLibrarySelected: {
                        showPhotoLibrary = true
                    }
                )
            }
            .sheet(isPresented: $showCamera) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .camera)
            }
            .sheet(isPresented: $showPhotoLibrary) {
                ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
            }
        }
    }
}

// MARK: - Form Sections
private extension App.Coffee.Views.Editor {
    var imageSection: some View {
        Section {
            HStack {
                Group {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                    } else if case .edit(let coffee) = mode,
                              let imageData = coffee.imageData,
                              let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("defaultpic")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: App.DesignSystem.Size.thumbnailHuge, height: App.DesignSystem.Size.thumbnailHuge)
                .clipShape(RoundedRectangle(cornerRadius: App.DesignSystem.CornerRadius.medium))

                Spacer()

                VStack(spacing: App.DesignSystem.Padding.element) {
                    Text(mode.isCreateMode ? "app.add.photo" : "app.change.photo")
                        .font(.headline)
                        .foregroundStyle(.primary)
                }

                Spacer()
            }
        }
        .onTapGesture {
            showSourceSheet = true
        }
    }

    var basicInformationSection: some View {
        Section("coffee.section.informations") {
            HStack(spacing: App.DesignSystem.Padding.medium) {
                App.DesignSystem.pickerImage(title: "cup.and.saucer.fill")
                TextField("coffee.name", text: $name)
                    .autocorrectionDisabled()
            }

            HStack(spacing: App.DesignSystem.Padding.medium) {
                App.DesignSystem.pickerImage(title: "text.alignleft")
                TextField("coffee.description", text: $shortDescription, axis: .vertical)
                    .lineLimit(2...4)
                    .autocorrectionDisabled()
            }

            HStack(spacing: App.DesignSystem.Padding.medium) {
                App.DesignSystem.pickerImage(title: App.DesignSystem.Icons.timer)
                Text("coffee.preparation.time")
                Spacer()
                Picker("", selection: $preparationTimeMinutes) {
                    ForEach([5, 10, 15, 20, 30, 45, 60, 90, 120], id: \.self) { minute in
                        Text("\(minute) min").tag(minute)
                    }
                }
                .pickerStyle(.menu)
                .foregroundStyle(.primary)
            }
        }
    }

    var optionsSection: some View {
        Section("coffee.options") {
            App.Coffee.Components.TypePicker(
                imageTitle: "star.fill",
                pickerTitle: "coffee.difficulty",
                selection: $difficulty,
                onChange: { _ in }
            )

            App.Coffee.Components.TypePicker(
                imageTitle: "cup.and.saucer.fill",
                pickerTitle: "coffee.glass.type",
                selection: $glassType,
                onChange: { _ in }
            )

            App.Coffee.Components.MultiTypePicker(
                imageTitle: "cup.and.heat.waves.fill",
                sectionTitle: "coffee.types",
                selections: Binding(
                    get: { Array(coffeeTypes) },
                    set: { coffeeTypes = Set($0) }
                ),
                onChange: { _ in }
            )
        }
    }

    var instructionsSection: some View {
        Section("coffee.instructions") {
            ForEach(instructions.indices, id: \.self) { index in
                HStack(spacing: App.DesignSystem.Padding.medium) {
                    Text("\(index + 1).")
                        .foregroundStyle(.secondary)
                        .frame(width: App.DesignSystem.Size.instructionNumberSize)

                    TextField("Step \(index + 1)", text: $instructions[index], axis: .vertical)
                        .lineLimit(1...3)
                }
            }
            .onDelete(perform: removeInstruction)

            Button("coffee.instruction.add") {
                instructions.append("")
            }
            .foregroundStyle(.blue)
        }
    }
}
