import UIKit

class DetailBuilder {
    static func build(with movie: Movie) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        viewController.presenter = presenter
        viewController.selectedMovie = movie
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        
        interactor.presenter = presenter
        
        router.viewController = viewController
        
        return viewController
    }
}
