import UIKit

class SearchBuilder {
    static func build() -> UIViewController {
        let viewController = SearchViewController()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(networkManager: DependencyContainer.shared.resolve(NetworkManagerProtocol.self))
        let router = SearchRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
