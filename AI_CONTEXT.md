# AI Context

This repository is designed for AI-assisted development (Claude Code, GitHub Copilot, etc.).
**このファイルを最初に読み、すべての実装判断の基準にしてください。**

---

## Architecture Rules (Strictly Enforced)

- **Feature → Domain**: ✅ Allowed
- **Feature → Infrastructure**: ❌ Forbidden — inject via protocol
- **Domain → Infrastructure**: ❌ Forbidden — Domain must stay pure

## Layer Responsibilities

| Layer | Responsibility | May depend on |
|---|---|---|
| Features | UI, ViewModel, state | Domain only |
| Domain | Models, Protocols, UseCases | Nothing |
| Infrastructure | Network, Persistence, Services | Domain protocols |
| Shared | Utilities, Extensions | Nothing |

---

## Patterns to Follow

- ViewModels use `@MainActor @Observable` (iOS 17+), NOT `ObservableObject`
- UseCase protocols and implementations are `@MainActor`
- Repository protocols and implementations are `@MainActor`
- `AppDependency` is `@MainActor` — Repository・UseCase・ViewModel を統一して生成する
- Views receive ViewModels via `init` injection, stored as `@State`
- ViewModel generation happens in `App.swift` (WindowGroup = `@MainActor`), NOT inside View `init`
- All async operations use `async/await`, NOT Combine / DispatchQueue
- Business logic lives in UseCases, NOT ViewModels
- Repository protocols are defined in Domain; implementations in Infrastructure

---

## Strictly Forbidden

以下は理由を問わず行わないでください：

| 禁止事項 | 代わりに使うもの |
|---|---|
| `ObservableObject` / `@Published` | `@MainActor @Observable` |
| `@StateObject` / `@ObservedObject` | `@State` (for `@Observable`) |
| `Combine` / `PassthroughSubject` | `async/await` |
| `DispatchQueue.main.async` | `@MainActor` / `.task` |
| `import SwiftData` in Domain layer | Infrastructure 層でのみ使う |
| `import UIKit` in Features/Domain | SwiftUI に統一 |
| `force unwrap` (`!`) | `guard let` / `if let` / `throws` |
| ViewModel 内で `APIClient` を直接呼ぶ | UseCase 経由で呼ぶ |
| View 内にビジネスロジックを書く | UseCase に移動する |
| `AnyObject` / 型消去を不必要に使う | 具体的な protocol を定義する |

---

## File Naming

- `FeatureNameView.swift` — SwiftUI View
- `FeatureNameViewModel.swift` — `@MainActor @Observable` ViewModel
- `FeatureNameUseCase.swift` — `@MainActor` Protocol + implementation (同一ファイル)
- `FeatureNameRepositoryProtocol.swift` — `@MainActor` Repository protocol (Domain)
- `FeatureNameRepository.swift` — `@MainActor` Repository implementation (Infrastructure)

---

## When Adding a Feature

1. Create `Packages/Core/Sources/Core/Features/FeatureName/`
2. Add `FeatureNameView.swift`, `FeatureNameViewModel.swift`, `FeatureNameUseCase.swift`
3. Define Domain model in `Domain/Models/`
4. Define `@MainActor` Repository protocol in `Domain/Repositories/`
5. Implement `@MainActor` Repository in `Infrastructure/Services/`
6. Register in `AppDependency.swift`
7. Add unit tests (`@MainActor` test class) in `Packages/Core/Tests/CoreTests/`

具体的な実装例は `examples/FeatureExample/README.md` を参照してください。

---

## When You Are Unsure

判断に迷ったときは以下の順で確認してください：

1. `docs/architecture.md` — レイヤー図とデータフローを確認
2. `examples/FeatureExample/README.md` — 具体的な実装例を確認
3. `ExampleFeature/` の既存コード — 実際のパターンを確認
4. それでも不明な場合は**実装を止めて質問する**（間違った方向に進まない）

---

## What NOT to Change Without Discussion

以下はプロジェクトオーナーの承認なく変更しないでください：

- `AI_CONTEXT.md` 自体の内容
- `docs/architecture.md` のレイヤー構造
- `AppDependency.swift` の設計方針
- `Packages/Core/Package.swift` への依存追加
- `.swiftlint.yml` の `force_unwrapping` ルール
