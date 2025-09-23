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

#### App.Coffee.Entities.Coffee (@Model)
- `id: UUID` (@Attribute(.unique)) - Identifiant unique auto-généré
- `name: String` (@Attribute(.unique)) - Nom unique du café
- `shortDescription: String` - Description courte
- `difficulty: Difficulty` - Niveau de difficulté
- `preparationTimeMinutes: Int` - Temps de préparation en minutes
- `glassType: GlassType` - Type de verre/contenant
- `coffeeType: [CoffeeType]` - Array de types (multi-tags)
- `imageData: Data?` (@Attribute(.externalStorage)) - Image stockée hors DB
- `imageName: String?` - Nom du fichier image (Assets, optionnel)
- `ingredients: [App.Ingredient.Entities.Ingredient]` (@Relationship(deleteRule: .cascade))

#### Propriétés @Transient (non persistées)
- `preparationTimeFormatted: String` - Temps formaté avec localisation
- `displayedImage: Image` - Image SwiftUI (Assets → trimmed name → imageData → défaut)
- `difficultyColor: Color` - Couleur selon difficulté (vert/jaune/rouge)

#### App.Ingredient.Entities.Ingredient (@Model)
- `id: UUID` (@Attribute(.unique)) - Identifiant unique auto-généré
- `name: String` - Nom de l'ingrédient
- `measure: Double` - Quantité
- `units: String` - Unités libres ("ml", "g", "tsp", etc.)
- `coffees: [App.Coffee.Entities.Coffee]` (@Relationship(deleteRule: .nullify))

### Relations Many-to-Many
- **Pas d'inverse** sur aucun des deux côtés pour Many-to-Many SwiftData
- **Coffee → Ingredients** : deleteRule .cascade (supprime ingrédients avec le café)
- **Ingredient → Coffees** : deleteRule .nullify (ingrédient reste si café supprimé)


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
- **Interface SwiftUI :**
  - CoffeeListView : Liste des cafés avec NavigationStack
  - CoffeeRow : Composant de ligne avec image, info, difficulté
  - Import automatique des données JSON au premier lancement
  - Debug des images avec logs console
- **Status actuel :** App fonctionnelle avec liste des cafés et import JSON

### Session 2 - 23/09/2025
- **Ajout des Instructions :** Propriété `instructions: [String]` ajoutée au modèle Coffee
- **JSON Sample Data :** Mise à jour avec 10 cafés complets incluant instructions détaillées
- **Persistence Layer :** Correction import JSON pour inclure les instructions
- **Design System Complet :**
  - `App.DesignSystem.Padding` : Système de padding basé sur la règle 4pt
  - `App.DesignSystem.Size` : Tailles standardisées pour tous les composants
  - `App.DesignSystem.Icons` : Centralisation des SF Symbols
- **Refactorisation Interface :**
  - CoffeeDetailView : Vue détaillée avec header, informations, ingrédients, instructions
  - CoffeeInformation : Composant avec icônes (temps, difficulté, type de verre)
  - CoffeeDifficultyTag : Système d'étoiles (★☆☆, ★★☆, ★★★)
  - CoffeeRow : Ligne de liste optimisée avec design system
  - CoffeeCard : Cartes compactes pour scroll horizontal
  - CoffeeHeader : Header d'image avec dégradé
- **HomePage Moderne :**
  - Section "Popular Coffees" avec scroll horizontal
  - Section Apple Intelligence avec gradient coloré
  - Quick Actions en grille 2x2
  - Navigation intégrée vers toutes les vues
- **Améliorations UX :**
  - Dark mode complet (suppression couleurs hardcodées)
  - Troncature des textes longs avec points de suspension
  - Animations fluides avec offset et opacity
  - Design cohérent sur toute l'app
- **Status actuel :** App complète avec homepage, détails, design system unifié

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