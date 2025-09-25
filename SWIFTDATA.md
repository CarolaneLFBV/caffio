# SwiftData Migration Strategy - Caffio

## Vue d'ensemble

Ce document planifie la stratégie de migration SwiftData pour l'évolution de Caffio vers des fonctionnalités avancées tout en préservant les données utilisateur existantes.

## Architecture Actuelle (V1.0)

### Modèles SwiftData Existants

#### App.Coffee.Entities.Coffee (@Model)
```swift
@Model
class Coffee {
    @Attribute(.unique) let id: UUID = UUID()
    @Attribute(.unique) var name: String
    var shortDescription: String
    var difficulty: Difficulty
    var preparationTimeMinutes: Int
    var glassType: GlassType
    var coffeeType: [CoffeeType]
    @Attribute(.externalStorage) var imageData: Data?
    var imageName: String?
    var instructions: [String]
    @Relationship(deleteRule: .cascade) var ingredients: [Ingredient] = []
    var isFavorite: Bool = false
}
```

#### App.Ingredient.Entities.Ingredient (@Model)
```swift
@Model
class Ingredient {
    @Attribute(.unique) let id: UUID = UUID()
    var name: String
    var measure: Double
    var units: String
    @Relationship(deleteRule: .nullify) var coffees: [Coffee] = []
}
```

### Enums Définis
- **Difficulty**: `easy`, `medium`, `hard`
- **GlassType**: `cup`, `mug`, `glass`, `tumbler`, `frenchPress`, `chemex`, `v60`
- **CoffeeType**: `hot`, `cold`, `short`, `long`, `iced`, `filtered`

## Stratégie de Migration

### 🎯 Principes Directeurs

1. **Préservation des données** : Aucune perte de données utilisateur
2. **Migrations additives** : Privilégier l'ajout vs modification
3. **Versioning proactif** : Préparer dès V1.0
4. **Rollback capability** : Possibilité de revenir en arrière

### 📋 Features Planifiées et Impact Migration

#### **Phase 1 : Consumption Tracking (V1.0 → V1.1)**
**Impact Migration** : ✅ **SAFE** - Ajout de nouveaux modèles uniquement

**Nouveaux modèles à ajouter :**
```swift
@Model
class CoffeeConsumption {
    @Attribute(.unique) let id: UUID = UUID()
    let timestamp: Date
    var coffee: Coffee // Relation vers Coffee existant
    var quantity: Double // ml ou cups
    var mood: String? // "energetic", "calm", "focused"
    var energyLevel: Int? // 1-5 scale
    var location: String? // "home", "office", "cafe"
    var notes: String?
    let createdAt: Date = Date.now
}

@Model
class DailyConsumptionSummary {
    @Attribute(.unique) let id: UUID = UUID()
    @Attribute(.unique) let date: Date // Jour unique
    var totalCups: Int = 0
    var totalCaffeine: Double = 0 // mg
    var averageMood: Double?
    var peakEnergyTime: Date?
    @Relationship(deleteRule: .cascade) var consumptions: [CoffeeConsumption] = []
}
```

**Relations ajoutées :**
```swift
// Extension du modèle Coffee existant (champs optionnels = migration safe)
extension Coffee {
    @Relationship(deleteRule: .cascade) var consumptions: [CoffeeConsumption] = []
    var averageRating: Double? // Calculé depuis les consumptions
    var lastConsumed: Date? // Dernière consommation
}
```

#### **Phase 2 : User Profile & Preferences (V1.1 → V1.2)**
**Impact Migration** : ✅ **SAFE** - Nouveaux modèles + champs optionnels

```swift
@Model
class UserProfile {
    @Attribute(.unique) let id: UUID = UUID()
    var preferredCaffeineLimit: Int = 400 // mg par jour
    var wakeUpTime: Date?
    var bedTime: Date?
    var preferredStrength: Int = 3 // 1-5 scale
    var tastingPreferences: TastingProfile?
    @Relationship(deleteRule: .cascade) var equipment: [CoffeeEquipment] = []
    let createdAt: Date = Date.now
}

@Model
class TastingProfile {
    @Attribute(.unique) let id: UUID = UUID()
    var acidityPreference: Int = 3 // 1-5
    var bitternessPreference: Int = 3
    var sweetnessPreference: Int = 3
    var bodyPreference: Int = 3 // light to full
    var preferredOrigins: [String] = [] // ["Ethiopia", "Colombia"]
    var dislikedFlavors: [String] = []
}

@Model
class CoffeeEquipment {
    @Attribute(.unique) let id: UUID = UUID()
    var name: String // "Hario V60"
    var type: EquipmentType // .dripper, .grinder, .scale
    var purchaseDate: Date?
    var notes: String?
}

enum EquipmentType: String, CaseIterable, Codable {
    case grinder, dripper, scale, kettle, frenchPress, espressoMachine
}
```

#### **Phase 3 : Social Features (V1.2 → V1.3)**
**Impact Migration** : ⚠️ **MODERATE** - Modification du modèle Coffee existant

```swift
// Ajouts au modèle Coffee (champs optionnels = safe)
extension Coffee {
    var isPublic: Bool = false
    var authorId: String? // User ID
    var rating: Double? // Community rating
    var downloadCount: Int = 0
    var tags: [String] = []
    var originalRecipeId: UUID? // Si c'est une variation
    @Relationship(deleteRule: .cascade) var reviews: [CoffeeReview] = []
}

@Model
class CoffeeReview {
    @Attribute(.unique) let id: UUID = UUID()
    var rating: Int // 1-5
    var comment: String?
    var authorId: String
    var coffee: Coffee
    let createdAt: Date = Date.now
}
```

#### **Phase 4 : Advanced Analytics (V1.3 → V1.4)**
**Impact Migration** : ✅ **SAFE** - Ajout de modèles analytiques

```swift
@Model
class BrewingSession {
    @Attribute(.unique) let id: UUID = UUID()
    var coffee: Coffee
    var startTime: Date
    var endTime: Date?
    var waterTemperature: Int? // Celsius
    var grindSize: String? // "medium-fine"
    var bloomTime: Int? // seconds
    var totalBrewTime: Int? // seconds
    var yield: Double? // ml
    var tds: Double? // Total Dissolved Solids %
    var extractionPercentage: Double?
    var personalRating: Int? // 1-5
    var notes: String?
}
```

## Schema Versioning Implementation

### Version 1.0 - État Initial
```swift
import SwiftData

enum SchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Coffee.self,
        Ingredient.self
    ]
}

// Container Setup
extension ModelContainer {
    static var caffioContainer: ModelContainer {
        let schema = Schema(versionedSchema: SchemaV1.self)
        let configuration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
```

### Version 1.1 - Consumption Tracking
```swift
enum SchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 1, 0)

    static var models: [any PersistentModel.Type] = [
        Coffee.self,
        Ingredient.self,
        CoffeeConsumption.self,
        DailyConsumptionSummary.self
    ]
}

// Migration Plan (si nécessaire)
enum MigrationPlan {
    static var plans: [SchemaMigrationPlan] = [
        // V1 -> V2 : Pas de migration nécessaire (nouveaux modèles seulement)
    ]
}
```

### Version 1.2 - User Profiles
```swift
enum SchemaV3: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 2, 0)

    static var models: [any PersistentModel.Type] = [
        Coffee.self,
        Ingredient.self,
        CoffeeConsumption.self,
        DailyConsumptionSummary.self,
        UserProfile.self,
        TastingProfile.self,
        CoffeeEquipment.self
    ]
}
```

## Préparation V1.0 (À implémenter MAINTENANT)

### 1. Ajout de Champs Future-Proof
```swift
// Modification recommandée du modèle Coffee actuel
@Model
class Coffee {
    // ... champs existants ...

    // Champs préparatoires (optionnels = pas de breaking change futur)
    var metadata: [String: String] = [:] // Stockage extensible
    var version: Int = 1 // Versioning interne
    let createdAt: Date = Date.now // Timestamp création
    var updatedAt: Date = Date.now // Timestamp modification

    // Future consumption tracking
    var totalConsumptions: Int = 0 // Cache count
    var lastConsumed: Date? // Dernière consommation

    // Future social features
    var isPublic: Bool = false // Partage public
    var tags: [String] = [] // Tags utilisateur
}
```

### 2. Configuration Container avec Versioning
```swift
// À ajouter dans App.swift
import SwiftData

@main
struct CaffioApp: App {
    let container: ModelContainer

    init() {
        do {
            // Schema avec versioning
            let schema = Schema(versionedSchema: SchemaV1.self)
            let configuration = ModelConfiguration(
                schema: schema,
                url: URL.documentsDirectory.appending(path: "Caffio.sqlite")
            )

            container = try ModelContainer(
                for: schema,
                configurations: [configuration]
            )

            // Migration future planning
            container.migrationPlan = MigrationPlan.plans

        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
```

## Risques et Mitigation

### 🔴 Risques Élevés
1. **Unique constraint sur `name`** : Pourrait poser problème avec partage social
   - **Mitigation** : Changer vers `@Attribute(.unique) var name: String` → `var name: String`
   - **Alternative** : Unique constraint composite (name + userId)

2. **Relations bidirectionnelles** : Actuellement bien gérées ✅

### 🟡 Risques Modérés
1. **Enum evolution** : Ajout de nouveaux cas
   - **Mitigation** : Enums String-based (actuels) sont extensibles ✅

2. **Performance avec volume** : Beaucoup de consommations
   - **Mitigation** : Index sur dates, pagination, cleanup automatique

### 🟢 Risques Faibles
1. **Nouveaux modèles** : Aucun impact sur existant
2. **Champs optionnels** : Migration transparente

## Timeline de Migration

### Phase 1 (Immédiat - V1.0)
- [ ] Ajouter schema versioning
- [ ] Ajouter champs future-proof optionnels
- [ ] Tester migration sur simulateur
- [ ] **Publier V1.0 avec préparation migration**

### Phase 2 (Post-lancement - V1.1)
- [ ] Implémenter CoffeeConsumption
- [ ] Créer interface tracking
- [ ] Tester migration V1.0 → V1.1
- [ ] **Déployer consumption tracking**

### Phase 3 (Expansion - V1.2+)
- [ ] User profiles
- [ ] Social features
- [ ] Advanced analytics

## Code Templates

### Template Migration Custom
```swift
struct MigratorV1toV2: SchemaMigrationPlan {
    static var sourceSchema = SchemaV1.self
    static var destinationSchema = SchemaV2.self

    static var stages: [MigrationStage] {
        [
            // Migration stages si transformation nécessaire
            .custom(
                fromVersion: SchemaV1.self,
                toVersion: SchemaV2.self,
                willMigrate: { context in
                    // Pre-migration setup
                },
                didMigrate: { context in
                    // Post-migration cleanup
                }
            )
        ]
    }
}
```

### Template Test Migration
```swift
#if DEBUG
extension ModelContainer {
    static var preview: ModelContainer {
        let schema = Schema(versionedSchema: SchemaV1.self)
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])

            // Seed data pour tests
            let context = container.mainContext
            // ... ajout de données test

            return container
        } catch {
            fatalError("Failed to create preview container: \(error)")
        }
    }
}
#endif
```

---

## Checkpoints de Validation

- [ ] **V1.0 Ready** : Schema versioning implémenté
- [ ] **Migration Safe** : Tests de migration en local
- [ ] **Data Preservation** : Vérification aucune perte
- [ ] **Performance** : Benchmarks avec gros volumes
- [ ] **Rollback** : Capacité de retour arrière

---

*Dernière mise à jour : 2025-09-25*
*Prochaine révision : Avant publication V1.0*