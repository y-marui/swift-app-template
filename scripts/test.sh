#!/bin/bash
set -e

echo "🧪 Running Core unit tests..."
swift test --package-path Packages/Core

echo "🧪 Running App integration tests..."
swift test --filter AppTests

echo "✅ All tests passed!"
