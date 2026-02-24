import UIKit

class SplashBuilder {
    static func build() -> UIViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
