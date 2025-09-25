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
│   ├── Structure.swift     # Définition des namespaces modulaires
│   └── Config.swift        # Configuration SwiftData centralisée
├── Shared/
│   ├── Localizable.xcstrings       # Localisations
│   ├── sample/coffees.json         # Données d'exemple (10 cafés)
│   └── caffioIcon.icon/            # Icône de l'application
└── Data/
    ├── Navigation/
    │   └── NavigationView.swift    # Navigation principale avec TabView
    ├── Coffee/
    │   ├── Domain/
    │   │   ├── Entities/           # Modèles SwiftData (Coffee + enums)
    │   │   ├── AI/                 # Couche Apple Intelligence
    │   │   │   ├── CoffeeGenerable.swift   # Structure @Generable IA
    │   │   │   └── CoffeeMaker.swift       # Classe interaction IA
    │   │   ├── Mocks/CoffeeMocks.swift     # Données de test
    │   │   └── Protocols/CoffeePersistenceProtocol.swift
    │   ├── Data/
    │   │   ├── Persistence/CoffeePersistence.swift  # Import JSON + CRUD
    │   │   └── Home/Presentation/HomeView/  # HomePage et composants
    │   └── Presentation/
    │       ├── Components/         # Composants réutilisables
    │       │   ├── CoffeeCard.swift         # Cartes compactes
    │       │   ├── CoffeeRow.swift          # Lignes de liste
    │       │   ├── CoffeeHeader.swift       # Header avec image
    │       │   └── CoffeeDifficultyTag.swift # Étoiles de difficulté
    │       └── Views/
    │           ├── ListView/CoffeeListView.swift    # Liste complète
    │           ├── DetailView/CoffeeDetailView.swift # Vue détaillée
    │           └── CoffeeMaker/CoffeeMakerView.swift # Interface IA
    ├── Ingredient/
    │   ├── Domain/
    │   │   ├── Entities/Ingredient.swift   # Modèle SwiftData
    │   │   ├── AI/IngredientGenerable.swift # Structure @Generable
    │   │   └── Mocks/IngredientMocks.swift # Données de test
    │   └── Presentation/
    │       └── Views/ListView/IngredientListView.swift
    └── DesignSystem/
        ├── Padding.swift   # Système de padding (règle 4pt)
        ├── Size.swift      # Tailles standardisées
        └── Icons.swift     # SF Symbols centralisés
```

### Namespaces définis
- `App.Core` - Fonctionnalités centrales (App, Structure, Config)
- `App.Coffee` - Gestion des cafés (Entities, Views, Components, AI)
- `App.Ingredient` - Gestion des ingrédients (Entities, AI)
- `App.DesignSystem` - Système de design (Padding, Size, Icons)

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
- FoundationModels framework préparé (iOS 26.0+)

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
- `instructions: [String]` - Instructions de préparation étape par étape
- `ingredients: [App.Ingredient.Entities.Ingredient]` (@Relationship(deleteRule: .cascade))

#### Propriétés @Transient (non persistées)
- `preparationTimeFormatted: String` - Temps formaté avec localisation
- `displayedImage: Image` - Image SwiftUI (Assets → trimmed name → imageData → défaut)
- `difficultyStars: Int` - Nombre d'étoiles selon difficulté (1-3)

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
- ✅ Intégration Apple Intelligence avec FoundationModels
- ✅ Interface utilisateur moderne en SwiftUI

### Technologies iOS à intégrer
- ✅ **SwiftData** - Modèles définis et relations configurées
- ✅ **FoundationModels / Apple Intelligence** - Framework IA implémenté avec @Generable
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

### Session 3 - 23/09/2025 (Après-midi)
- **Objectif principal :** Implémentation Apple Intelligence avec FoundationModels
- **Documentation technique :** Création complète FOUNDATIONMODELS.md (1900+ lignes)
- **Architecture AI implémentée avec succès :**
  - App.Coffee.AI.CoffeeMaker : Classe @Observable pour interactions IA
  - App.Coffee.Views.CoffeeMakerView : Interface SwiftUI complète avec streaming
  - App.Coffee.AI.CoffeeGenerable : Structure @Generable pour génération de cafés
  - App.Ingredient.AI.IngredientGenerable : Structure @Generable pour ingrédients
- **Fonctionnalités développées :**
  - Interface utilisateur complète avec états (génération, erreur, succès)
  - Intégration @Generable avec conversion vers entités SwiftData
  - Gestion des erreurs et vérifications de disponibilité iOS 26.0+
  - Streaming des réponses IA en temps réel avec feedback visuel
  - Sauvegarde automatique des recettes générées dans SwiftData
- **Refactorisation architecture :**
  - Suppression couches Repository pour simplification
  - Migration Ingredient vers structure modulaire complète
  - Ajout App.Core.Config pour centralisation SwiftData
- **Status actuel :** Apple Intelligence fonctionnelle et intégrée

### Session 4 - 24/09/2025
- **Objectif :** Analyse et mise à jour de la documentation suite aux développements récents
- **Changements identifiés :**
  - ✅ Apple Intelligence/FoundationModels completement implémentée
  - ✅ Architecture AI fonctionnelle avec streaming temps réel
  - ✅ Documentation technique complète (FOUNDATIONMODELS.md)
  - ✅ Refactorisation et simplification de l'architecture
  - ✅ Migration Ingredient vers structure modulaire
  - ✅ Configuration SwiftData centralisée
- **Status actuel :** Application complète avec IA intégrée et fonctionnelle

### Session 5 - 24/09/2025 (Suite)
- **Objectif principal :** Implémentation CoffeeEditView et système de Pickers réutilisables
- **Nouvelles fonctionnalités développées :**
  - **CoffeeEditView.swift :** Interface d'édition complète avec Form SwiftUI
  - **Système TypePicker générique :** Pickers réutilisables pour sélections uniques (Difficulty, GlassType)
  - **MultiTypePicker :** Composant pour sélections multiples (CoffeeType array)
  - **Navigation "Browse All" :** Depuis HomePage vers CoffeeListView
  - **Fonctionnalité favoris :** Toggle dans CoffeeDetailView avec persistance
- **Architecture des Pickers :**
  - `TypePicker<T>` générique avec constraints `CaseIterable & Hashable & RawRepresentable`
  - Design cohérent avec `pickerImage()` et design system unifié
  - Callbacks `onChange` pour actions personnalisées
  - `MultiTypePicker` pour gestion des arrays avec logique toggle intégrée
- **Améliorations modèle Coffee :**
  - Ajout propriété `note: Int` pour système de notation utilisateur
  - Propriété `isFavorite: Bool` pour gestion des favoris avec persistance SwiftData
  - Méthode `preparationTimeFormatted` mise à jour avec localisation "min"
- **Interface utilisateur avancée :**
  - Form SwiftUI organisée en sections (Informations, Options, Instructions)
  - Validation temps réel (nom requis pour activer bouton sauvegarder)
  - Gestion dynamique des instructions avec ajout/suppression via onDelete
  - Navigation toolbar avec boutons localisés Annuler/Sauver
  - Menu contextuel étendu dans CoffeeDetailView (Edit/Delete/Favorite)
- **Navigation et UX :**
  - QuickActionCard "Browse All" fonctionnelle avec showCoffeeList @State
  - navigationDestination vers App.Coffee.Views.List()
  - Menu ellipsis dans CoffeeDetailView avec sections organisées
  - Intégration complète des actions favoris avec feedback visuel
- **Internationalisation étendue :**
  - 25+ nouvelles clés de localisation pour formulaire d'édition
  - Support app.edit, app.cancel, app.save, app.favorite, app.unfavorite
  - Strings localisés pour toutes les sections et champs du formulaire
  - Support pluriels pour instructions et temps de préparation
- **Status actuel :** App complète avec édition avancée, favoris, et navigation optimisée

### Session 6 - 24/09/2025 (Continuation)
- **Objectif principal :** Améliorations UX et implémentation des transitions zoom
- **Nettoyage Design System complet :**
  - Padding : Réduction de 16 à 7 valeurs essentielles (suppression des valeurs non utilisées)
  - Size : Réduction de 35 à 11 valeurs (conservation des tailles critiques)
  - Icons : Réduction de 50+ à 8 icônes essentielles (search, star, favorite, coffee, timer, difficulty, clock, intelligence)
  - Analyse systématique avec grep pour identifier les valeurs réellement utilisées
- **Système de favoris avancé :**
  - CoffeeToggleButton : Composant réutilisable avec glassmorphism (.regularMaterial)
  - Badge de favoris sur CoffeeRow et CoffeeCard (overlay en coin d'image)
  - Persistance SwiftData avec gestion d'erreurs
  - Design cohérent avec CornerRadius.xsmall
- **Nouveau Design System CornerRadius :**
  - Ajout fichier CornerRadius.swift suivant la règle 4pt
  - xsmall: 4 (toggle buttons), small: 8 (images), medium: 12 (cards et containers)
  - Remplacement des valeurs hardcodées dans toute l'app
- **ShelfList fonctionnelle :**
  - Création vue complète pour les cafés favoris
  - @Query avec #Predicate pour filtrer isFavorite == true
  - État vide avec instructions claires
  - Navigation vers DetailView intégrée
  - Fix du freeze de l'app lors du clic sur "Shelf"
- **Transitions zoom avancées :**
  - Implémentation @Namespace et matchedTransitionSource sur CoffeeCard
  - .navigationTransition(.zoom) de HomeView vers DetailView
  - Animation fluide card-to-detail avec ID unique (coffee.id)
  - Support namespace partagé entre composants
- **Localisation améliorée :**
  - Section headers avec LocalizedStringKey dans HomeView
  - Ajout clés home.section.* dans Localizable.xcstrings
  - Support internationalisation pour futures langues
- **Optimisations techniques :**
  - Extraction code dupliqué vers composants réutilisables
  - Amélioration gestion des erreurs avec logs console
  - Cohérence des corner radius et padding dans toute l'app
  - Simplification des previews avec @Previewable @Namespace
- **Status actuel :** App polie avec transitions fluides, favoris fonctionnels, design system optimisé

## État actuel de l'application

### Features complètes et fonctionnelles ✅
- ✅ **Modèles SwiftData** : Coffee et Ingredient avec relations many-to-many
- ✅ **Design System optimisé** : Padding (7 valeurs), Size (11 valeurs), Icons (8 valeurs), CornerRadius (3 valeurs)
- ✅ **HomePage moderne** : Popular Coffees, Apple Intelligence avec transitions zoom
- ✅ **Navigation complète** : TabView, NavigationStack, destinations avec Shelf fonctionnelle
- ✅ **Interface Coffee** : Liste, détails, **édition complète**, ShelfList avec favoris
- ✅ **Import JSON** : 10 cafés d'exemple avec instructions détaillées
- ✅ **Dark Mode** : Compatible avec glassmorphism effects (.regularMaterial)
- ✅ **Composants UI avancés** : Cards avec badges favoris, Rows optimisées, TypePickers génériques
- ✅ **Apple Intelligence** : Génération IA de recettes complètes avec streaming
- ✅ **FoundationModels** : @Generable, @Observable, conversion SwiftData
- ✅ **CoffeeMaker IA** : Interface complète pour création assistée par IA
- ✅ **CoffeeEditView** : Formulaire d'édition avec TypePicker et MultiTypePicker
- ✅ **Système de favoris complet** : Toggle buttons, badges visuels, ShelfList filtrée, persistance
- ✅ **Transitions fluides** : Zoom animation avec @Namespace de cards vers DetailView
- ✅ **Localisation** : Section headers internationalisables, clés home.section.*

### Architecture finale optimisée
```
App complète et polie avec :
- SwiftData persistence layer avec favoris et notes
- Apple Intelligence intégrée (FoundationModels)
- Design system optimisé (Padding: 7, Size: 11, Icons: 8, CornerRadius: 3 valeurs)
- Transitions zoom fluides avec @Namespace
- Système de favoris complet avec badges et ShelfList
- Composants réutilisables (ToggleButton, TypePicker, etc.)
- Glassmorphism effects avec .regularMaterial
- Homepage attrayante avec navigation complète
- Dark mode support complet
- Localisation préparée pour internationalisation
- Seed data complet (10 cafés avec instructions)
- Génération IA de recettes avec streaming
- UX polie avec états vides et gestion d'erreurs
```

### Prochaines étapes recommandées
1. **Tests E2E complets** : Coverage des transitions, favoris, IA, et navigation
2. **Performance** : Optimisations Image loading, caching, et animations
3. **Accessibilité** : Audit WCAG avec support VoiceOver pour badges et transitions
4. **Vision Framework** : Reconnaissance automatique d'images de cafés
5. **WidgetKit** : Widgets favoris avec accès rapide aux recettes
6. **CloudKit Sync** : Synchronisation des favoris entre appareils
7. **Système notation avancé** : Notes utilisateur avec moyenne et statistiques

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
*Dernière mise à jour : 24/09/2025 - Session 6 (Transitions zoom et design system optimisé)*