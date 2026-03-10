# Development Guide

## Setup

```bash
git clone <repo>
cd <repo>
make bootstrap
```

## Daily Commands

| Command | Description |
|---|---|
| `make lint` | Run SwiftLint |
| `make format` | Run SwiftFormat |
| `make test` | Run all tests |
| `make clean` | Clean build artifacts |

## Adding a New Feature

1. Create directory:
   ```
   Packages/Core/Sources/Core/Features/MyFeature/
   ```

2. Copy templates:
   ```bash
   cp templates/feature/View.swift.template Packages/Core/Sources/Core/Features/MyFeature/MyFeatureView.swift
   cp templates/feature/ViewModel.swift.template Packages/Core/Sources/Core/Features/MyFeature/MyFeatureViewModel.swift
   cp templates/feature/UseCase.swift.template Packages/Core/Sources/Core/Features/MyFeature/MyFeatureUseCase.swift
   ```

3. Replace `{{FeatureName}}` with your feature name.

4. Add Domain model to `Domain/Models/`.

5. Add Repository protocol to `Domain/Repositories/`.

6. Add Repository implementation to `Infrastructure/Services/`.

7. Register in `AppDependency.swift`:
   ```swift
   func makeMyFeatureViewModel() -> MyFeatureViewModel {
       MyFeatureViewModel(useCase: MyFeatureUseCase(repository: myRepository))
   }
   ```

## Testing

- Unit tests live in `Packages/Core/Tests/CoreTests/`
- Always mock dependencies via protocols
- Follow Given / When / Then structure

```swift
func test_onAppear_loadsItems() async {
    // Given
    let mock = MockUseCase(result: .success([...]))
    let sut = MyViewModel(useCase: mock)

    // When
    await sut.onAppear()

    // Then
    XCTAssertEqual(...)
}
```
