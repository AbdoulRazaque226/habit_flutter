# Habitude & Bien-être 🌱

![CI](https://github.com/AbdoulRazaque226/<ton-repo>/actions/workflows/ci.yml/badge.svg)
![Flutter](https://img.shields.io/badge/Flutter-3.35-blue)
![License](https://img.shields.io/badge/license-MIT-green)

Une application Flutter de suivi d'habitudes quotidiennes, construite selon une
architecture Feature-First / Clean Architecture, avec persistance locale,
internationalisation FR/EN et une suite de tests complète.

## 📱 Aperçu

| Onboarding | Liste | Détail | Stats | Réglages |
|---|---|---|---|---|
| ![onboarding](screenshots/onboarding.png) | ![liste](screenshots/list.png) | ![détail](screenshots/detail.png) | ![stats](screenshots/stats.png) | ![réglages](screenshots/settings.png) |

> Ajoute tes propres captures d'écran dans un dossier `screenshots/` à la racine
> du projet et remplace les chemins ci-dessus.

## ✨ Fonctionnalités

- Créer, cocher et supprimer des habitudes quotidiennes
- Suivi de série (streak) et historique visuel sur 30 jours
- Statistiques globales (taux de complétion, meilleure série)
- Français / Anglais, thème clair / sombre
- Persistance locale hors ligne (Hive)
- Accessibilité : labels sémantiques fusionnés sur les éléments interactifs

## 🏗️ Architecture

Le projet suit une architecture **Feature-First** avec séparation en couches
**data / domain / presentation** pour chaque fonctionnalité :

```
lib/
├── core/               # thème, constantes, widgets partagés (transverse)
├── l10n/               # fichiers .arb (FR/EN) + fichiers générés
├── router/             # go_router
└── features/
    ├── habits/         # data + domain + presentation (feature principale)
    │   ├── data/           # HabitModel (Hive), HabitRepositoryImpl
    │   ├── domain/         # entité Habit, interface HabitRepository
    │   └── presentation/   # providers Riverpod, écrans, widgets
    ├── onboarding/     # présentation seule
    ├── stats/          # présentation seule
    └── settings/       # présentation + providers de préférences
```

- **State management** : Riverpod (`StateNotifierProvider`, `select` pour
  limiter les rebuilds aux données réellement utilisées par chaque écran)
- **Persistance** : Hive
- **Navigation** : go_router
- **Repository pattern** pour isoler la source de données du reste de l'app,
  ce qui facilite les tests unitaires (mock/fake du repository)

## 🚀 Installation

```bash
git clone https://github.com/AbdoulRazaque226/<ton-repo>.git
cd <ton-repo>
flutter pub get
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## 🧪 Tests

```bash
# Tests unitaires et widgets
flutter test

# Tests d'intégration (parcours complet de l'app)
flutter test integration_test
```

Couverture de la suite de tests :
- **10+ tests unitaires** — logique de l'entité `Habit` (streak, complétion) et
  du `HabitRepositoryImpl` (CRUD via Hive)
- **6 tests de widgets** — comportement et rendu de `HabitTile`
  (affichage, interactions, accessibilité)
- **2 tests d'intégration** — parcours complet (onboarding → ajout d'une
  habitude → affichage) et navigation entre écrans

## ⚡ Performance & accessibilité

- Liste des habitudes rendue en `ListView.builder` (lazy loading)
- `HabitDetailScreen` utilise `select` sur le provider pour ne se reconstruire
  que si l'habitude affichée change, pas à chaque mise à jour de la liste
- Constructeurs `const` utilisés partout où c'est possible
- `MergeSemantics` sur `HabitTile` pour une annonce cohérente et non
  dupliquée par les lecteurs d'écran

## 📦 Build

```bash
flutter build apk --release
```

L'APK signé est disponible dans `build/app/outputs/flutter-apk/app-release.apk`,
et également généré automatiquement par le pipeline CI (voir l'artefact
`release-apk` du workflow GitHub Actions).

## 🔧 CI/CD

Le pipeline GitHub Actions (`.github/workflows/ci.yml`) exécute à chaque push
et pull request sur `main` :
1. Installation des dépendances et génération des fichiers l10n/Hive
2. Vérification du formatage (`dart format`)
3. Analyse statique (`flutter analyze`)
4. Tests unitaires et widgets avec couverture
5. Build de l'APK de release

## 📄 Licence

MIT