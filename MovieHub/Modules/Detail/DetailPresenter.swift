import Foundation

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorProtocol?
    var router: DetailRouterProtocol?
    
    func viewDidLoad() {
        interactor?.checkScreenReady()
    }
    
    func screenReady() {
        view?.showMovieInformation()
    }
}
