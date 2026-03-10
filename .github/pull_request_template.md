## Summary

<!-- Describe the changes and the motivation behind them. -->

## Type of change

- [ ] Bug fix
- [ ] New feature / template addition
- [ ] Refactoring (no functional change)
- [ ] Documentation update

## Code review checklist

- [ ] Feature が Infrastructure を直接 import していないか
- [ ] Domain モデルに framework の import がないか
- [ ] ViewModel が `@MainActor @Observable` になっているか
- [ ] 非同期処理が `async/await` になっているか（Combine 禁止）
- [ ] 新しい UseCase・Repository にテストが追加されているか
- [ ] `force_unwrap`（`!`）を使っていないか

## Testing

- [ ] `make test` が通ることを確認した
- [ ] `make lint` が 0 violations であることを確認した

## Related issues

<!-- Closes # -->
