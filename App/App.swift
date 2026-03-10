import SwiftUI

@main
struct ExampleApp: App {

    // AppDependencyはMainActorに縛られないため@Stateで保持
    private let dependency = AppDependency()

    var body: some Scene {
        WindowGroup {
            // ViewModel生成はここで行う(@MainActorコンテキスト)
            RootView(
                dependency: dependency,
                exampleViewModel: dependency.makeExampleViewModel()
            )
        }
    }
}
