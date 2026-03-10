# Architecture

## Overview

This project follows Clean Architecture principles, organized into 4 layers with strict dependency rules.

## Layer Diagram

```
┌─────────────────────────────────┐
│           App (Entry)           │
│  App.swift / AppDependency.swift│
└────────────┬────────────────────┘
             │ injects
┌────────────▼────────────────────┐
│          Features               │
│  View + ViewModel + UseCase     │
│  (depends on Domain only)       │
└────────────┬────────────────────┘
             │ uses protocols
┌────────────▼────────────────────┐
│           Domain                │
│  Models / Repositories / UseCases│
│  (pure Swift, no dependencies)  │
└────────────┬────────────────────┘
             │ implemented by
┌────────────▼────────────────────┐
│        Infrastructure           │
│  Network / Persistence / Services│
└─────────────────────────────────┘
```

## Data Flow

```
User Action
  → ViewModel.action()
    → UseCase.execute()
      → Repository.fetch()   (protocol call)
        → APIClient / SwiftData  (implementation)
      ← [DomainModel]
    ← [DomainModel]
  ← ViewModel updates state
View re-renders automatically via @Observable
```

## ViewModel Pattern

All ViewModels use `@Observable` (iOS 17+):

```swift
@Observable
final class FeatureViewModel {
    private(set) var state: ViewState = .idle
    private let useCase: FeatureUseCaseProtocol

    init(useCase: FeatureUseCaseProtocol) {
        self.useCase = useCase
    }

    func onAppear() async { ... }
}
```

## Dependency Injection

`AppDependency` is the single source of truth for object creation.
It is created once in `App.swift` and passed down via `init`.

```swift
// App.swift
@State private var dependency = AppDependency()

// AppDependency.swift
func makeFeatureViewModel() -> FeatureViewModel {
    FeatureViewModel(useCase: FeatureUseCase(repository: featureRepository))
}
```
