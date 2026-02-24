# 🎬 MovieHub

A film discovery iOS application built with **VIPER architecture**, offering real-time search and filtering across 10,000+ movies powered by the TMDB API.

## Screenshots

*Screenshots coming soon*

## Tech Stack

| Category | Technologies |
|----------|-------------|
| **Language** | Swift |
| **Architecture** | VIPER |
| **UI** | UIKit (Programmatic, No Storyboard), Auto Layout |
| **Reactive** | Combine |
| **Networking** | Alamofire |
| **Dependency Injection** | Swinject |
| **Image Loading** | Kingfisher |
| **Dependency Management** | CocoaPods, SPM |

## Architecture

The project follows **VIPER** (View, Interactor, Presenter, Entity, Router) architecture with full separation of concerns:

```
MovieHub/
├── App/                    # App lifecycle
├── Core/
│   ├── Coordinator/        # Navigation coordination
│   ├── DI/                 # Dependency injection container
│   ├── Managers/           # App-wide managers
│   ├── Network/            # API service layer
│   └── Storage/            # Core Data stack
├── Modules/
│   ├── Splash/             # Splash module (View, Interactor, Presenter, Router, Contract)
│   └── Home/               # Home module (View, Interactor, Presenter, Router, Contract)
├── Common/
│   ├── Constants/          # App constants
│   ├── Extensions/         # Swift extensions
│   ├── Views/              # Reusable UI components
│   └── Protocols/          # Shared protocols
└── Resources/
    ├── Assets.xcassets/    # Images and colors
    └── Localizable/        # en.lproj, tr.lproj
```

## Features

- 🔍 Real-time search and filtering across 10,000+ film records
- 🏗️ Modular VIPER architecture with protocol-based contracts
- ⚡ Combine-powered reactive data flow
- 🖥️ 100% programmatic UI — zero Storyboard dependency
- 🌍 Turkish/English localization
- 🌙 Dark/Light mode support
- 💉 Swinject for dependency injection
- 🖼️ Kingfisher for optimized image caching
- 🧩 Custom UITableView & UICollectionView components

## Setup

1. Clone the repository
```bash
git clone https://github.com/Aliboztepe/MovieHub.git
```

2. Create a `Secrets.swift` file in the project root with your TMDB API key:
```swift
enum Secrets {
    static let apiKey = "YOUR_TMDB_API_KEY"
}
```

3. Get your free API key from [themoviedb.org](https://www.themoviedb.org/settings/api)

4. Open `MovieHub.xcodeproj` in Xcode and run
