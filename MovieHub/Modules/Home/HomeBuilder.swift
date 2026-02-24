import UIKit

class HomeBuilder {
    static func build() -> UIViewController {
        let viewController = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(
            networkManager: DependencyContainer.shared.resolve(NetworkManagerProtocol.self)
        )
        let router = HomeRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
