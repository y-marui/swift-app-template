import Foundation

// MARK: - AppDependency
// Central dependency container. Created once in App.swift, injected downward.
// Repository・UseCase・ViewModel はすべて @MainActor のため、
// ファクトリメソッドを @MainActor に統一する。

@MainActor
final class AppDependency {

    // MARK: - Infrastructure

    let apiClient: APIClientProtocol

    // MARK: - Repositories

    let exampleRepository: ExampleRepositoryProtocol

    // MARK: - Init

    init() {
        // Replace "https://api.example.com" with your actual endpoint.
        guard let baseURL = URL(string: "https://api.example.com") else {
            fatalError("Invalid base URL. Update AppDependency.init() before running.")
        }
        self.apiClient = APIClient(baseURL: baseURL)

        // Choose pattern A (API) or pattern B (SwiftData local).
        // Pattern A: self.exampleRepository = ExampleAPIRepository(apiClient: apiClient)
        // Pattern B: self.exampleRepository = ExampleLocalRepository(context: yourModelContext)
        self.exampleRepository = ExampleAPIRepository(apiClient: apiClient)
    }

    // MARK: - ViewModel Factories

    func makeExampleViewModel() -> ExampleViewModel {
        let useCase = ExampleUseCase(repository: exampleRepository)
        return ExampleViewModel(useCase: useCase)
    }
}
