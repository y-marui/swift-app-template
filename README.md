# Swift AI App Template

![CI](https://github.com/your-org/your-repo/actions/workflows/ci.yml/badge.svg)

Template optimized for small teams, AI-assisted development, and long-term maintainability.

## Features

- ✅ Clean Architecture (Feature / Domain / Infrastructure)
- ✅ `@Observable` ViewModels (iOS 17+)
- ✅ Manual dependency injection via `AppDependency`
- ✅ SwiftData persistence layer
- ✅ Async/await networking with `URLSession`
- ✅ XCTest with mock examples
- ✅ SwiftLint + SwiftFormat configured
- ✅ GitHub Actions CI (lint + test)
- ✅ AI-friendly context files (`AI_CONTEXT.md`, `PROJECT_CONTEXT.md`)

## Requirements

- Xcode 15+
- iOS 17+ / macOS 14+
- Swift 5.9+

## Quick Start

```bash
git clone <repo>
cd <repo>
make bootstrap
```

その後、Xcodeで新規iOSプロジェクトを作成し、`Packages/Core` をローカルパッケージとして追加してください。
詳細は `Package.swift` のコメントを参照。

## Commands

| Command | Description |
|---|---|
| `make bootstrap` | Install tools, resolve packages |
| `make lint` | Run SwiftLint |
| `make format` | Run SwiftFormat |
| `make test` | Run all tests |
| `make clean` | Clean build artifacts |

## Project Structure

```
Package.swift           # Root — テスト実行・パッケージ管理用
App/                    # Entry point and DI container
Packages/Core/          # Swift Package with all features
  Sources/Core/
    Features/           # UI + ViewModel per feature
    Domain/             # Models, Protocols (no dependencies)
    Infrastructure/     # Network, Persistence (implements Domain protocols)
    Shared/             # Utilities
.github/workflows/      # GitHub Actions CI
docs/                   # Architecture and development guides
templates/feature/      # Code templates for new features
scripts/                # Shell scripts
```

## Documentation

- [Architecture](docs/architecture.md)
- [Development Guide](docs/development.md)
- [Maintenance](docs/maintenance.md)
- [Runbook](docs/runbook.md)

## AI-Assisted Development

This template is optimized for Claude Code and GitHub Copilot.
See [`AI_CONTEXT.md`](AI_CONTEXT.md) for rules and patterns the AI should follow.
