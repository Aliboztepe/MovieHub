import Foundation
import Swinject

final class DependencyContainer {
    static let shared = DependencyContainer()

    let container = Container()

    private init() {
        registerDependencies()
    }

    private func registerDependencies() {
        container.register(NetworkManagerProtocol.self) { _ in
            NetworkManager()
        }
    }

    func resolve<T>(_ type: T.Type) -> T {
        guard let resolved = container.resolve(T.self) else {
            fatalError("Could not resolve \(T.self)")
        }
        return resolved
    }
}
