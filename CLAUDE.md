# Caffio - Application iOS de Gestion de Cafés

## Vue d'ensemble du projet

**Nom du projet :** Caffio
**Plateforme :** iOS (SwiftUI)
**Version iOS cible :** 26.0+
**Bundle ID :** carolanelefebvre.caffio

### Objectif principal
Développer une application iOS permettant de créer et gérer ses propres cafés avec recettes et intégration d'Apple Intelligence.

## Structure du projet actuel

### Architecture des fichiers
```
caffio/
├── Core/
│   ├── App.swift           # Point d'entrée de l'application
│   └── Structure.swift     # Définition des namespaces modulaires
└── Data/
    └── Coffee/
        └── Views/
            └── ContentView.swift  # Vue principale (template de base)
```

### Namespaces définis
- `App.Core` - Fonctionnalités centrales
- `App.Coffee` - Gestion des cafés (Entities, Views, Components)
- `App.Ingredient` - Gestion des ingrédients
- `App.DesignSystem` - Système de design

## Configuration technique actuelle

### Environnement de développement
- **Xcode :** 26.0
- **Swift :** 5.0
- **iOS Deployment Target :** 26.0
- **Team ID :** 6DJTCJY48F
- **SwiftUI :** Activé avec previews
- **Swift Concurrency :** Mode approachable activé

### Fonctionnalités activées
- SwiftUI avec génération automatique d'Info.plist
- Swift concurrency avec MainActor par défaut
- Génération de symboles pour les catalogues de chaînes
- Support universel (iPhone et iPad)

## Modèle de données SwiftData

### Enums définis
- **Difficulty** : `easy`, `medium`, `hard` (localisés en anglais)
- **GlassType** : `cup`, `mug`, `glass`, `tumbler`, `frenchPress`, `chemex`, `v60` (localisés en anglais)
- **CoffeeType** : `hot`, `cold`, `short`, `long`, `iced`, `filtered` (localisés en anglais)

### Modèles SwiftData

#### Coffee.Model (@Model)
- `id: UUID` (@Attribute(.unique)) - Identifiant unique auto-généré
- `name: String` (@Attribute(.unique)) - Nom unique du café
- `shortDescription: String` - Description courte
- `difficulty: Difficulty` - Niveau de difficulté
- `preparationTimeMinutes: Int` - Temps de préparation en minutes
- `glassType: GlassType` - Type de verre/contenant
- `coffeeType: [CoffeeType]` - Array de types (multi-tags)
- `imageData: Data?` (@Attribute(.externalStorage)) - Image stockée hors DB
- `imageName: String?` - Nom du fichier image (Assets, optionnel)
- `ingredients: [Ingredient]` (@Relationship(deleteRule: .cascade))

#### Propriétés @Transient (non persistées)
- `preparationTimeFormatted: String` - Temps formaté avec localisation
- `displayedImage: Image` - Image SwiftUI (Assets → imageData → défaut)
- `difficultyColor: Color` - Couleur selon difficulté (vert/jaune/rouge)

#### Init avec valeurs par défaut
- Tous les paramètres ont des valeurs par défaut
- `glassType` défaut = `.cup`, `difficulty` défaut = `.easy`
- UUID auto-généré, `imageName` optionnel

#### Ingredient (@Model)
- `id: UUID` (@Attribute(.unique)) - Identifiant unique auto-généré
- `name: String` - Nom de l'ingrédient
- `measure: Double` - Quantité
- `units: String` - Unités libres ("ml", "g", "tsp", etc.)
- `coffees: [Coffee.Model]` (@Relationship(deleteRule: .nullify))

#### Init avec valeurs par défaut
- UUID auto-généré, tous paramètres avec défauts

### Relations
- **Coffee → Ingredients** : One-to-Many (cascade delete)
- **Ingredient → Coffees** : Many-to-Many (nullify delete)

## Architecture Data Layer

### Structure organisée
```
caffio/Data/Coffee/
├── Entities/           # Modèles SwiftData
├── Domain/Protocols/   # Protocoles pour testabilité
├── Data/
│   ├── Persistence/    # Communication SwiftData
│   └── Repository/     # Logique métier
└── Views/             # Interface SwiftUI
```

### Couches et responsabilités
- **Persistence** : CRUD SwiftData + import JSON
- **Repository** : Filtres, recherche, logique métier
- **Protocoles** : `Storable` pour dependency injection
- **Seed Data** : `/Shared/sample/coffees.json` (10 cafés)

## Fonctionnalités prévues

### Core Features (Modèle défini)
- ✅ Gestion des profils de café avec SwiftData
- ✅ Stockage des recettes avec ingrédients
- 🔄 Intégration Apple Intelligence
- 🔄 Interface utilisateur moderne en SwiftUI

### Technologies iOS à intégrer
- ✅ **SwiftData** - Modèles définis et relations configurées
- 🔄 **Core ML / Apple Intelligence** - Fonctionnalités IA
- 🔄 **Vision Framework** - Reconnaissance d'images
- 🔄 **WidgetKit** - Widgets de suivi (optionnel)

## Historique des sessions

### Session 1 - 22/09/2025
- **Analyse initiale :** Structure du projet existant analysée
- **État :** Projet iOS SwiftUI de base créé avec structure modulaire
- **Modèles SwiftData :** Création complète des modèles Coffee et Ingredient
- **Enums :** Difficulty, GlassType, CoffeeType avec localisations anglaises
- **Relations :** Configuration des relations bidirectionnelles avec règles de suppression
- **Améliorations Coffee Model :**
  - Ajout UUID unique avec auto-génération
  - CoffeeType converti en array pour multi-tags
  - Ajout imageName pour référencer les Assets
  - Init avec valeurs par défaut complètes
  - Simplification (suppression dates de création/modification)
- **Architecture Data Layer :**
  - CoffeePersistence : Communication directe avec SwiftData
  - CoffeeRepository : Logique métier et filtres
  - Protocoles : `App.Coffee.Protocols.Storable` pour testabilité
  - Import JSON : Seed data au premier lancement (`coffees.json`)
- **Prochaines étapes :** Interface SwiftUI et ViewModels

---

## Notes pour Claude

### Rappels importants
- Ce projet est en phase de préparation
- L'utilisateur souhaite documenter le progrès au fur et à mesure
- Maintenir ce fichier CLAUDE.md à jour après chaque session significative
- Focus sur une architecture modulaire et des bonnes pratiques SwiftUI

### Conventions de code observées
- Utilisation de namespaces via extensions
- Structure modulaire claire (Core, Coffee, Ingredient, DesignSystem)
- SwiftUI avec previews activés

---
*Dernière mise à jour : 22/09/2025*