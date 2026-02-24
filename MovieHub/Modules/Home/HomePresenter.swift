import Foundation

class HomePresenter: HomePresenterProtocol {
    weak var view: HomeViewProtocol?
    weak var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchMovies()
    }

    func didSelectMovie(_ movie: Movie) {
        router?.navigateToDetail(movie: movie)
    }

    func fetchMoviesSuccess(popular: [Movie], topRated: [Movie], upcoming: [Movie]) {
        view?.showMovies(popular: popular, topRated: topRated, upcoming: upcoming)
    }

    func fetchMoviesFailed(error: NetworkError) {
        view?.showError(error.localizedDescription)
    }
}
