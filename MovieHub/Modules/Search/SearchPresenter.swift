import Foundation

class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?
    
    func viewDidLoad() {
        
    }
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            view?.showEmptyState()
            return
        }
        
        view?.showLoading()
        interactor?.searchMovies(query: query)
    }
    
    func didSelectMovie(movie: Movie) {
        router?.navigateToDetail(movie: movie)
    }
    
    func fetchMoviesSuccess(movies: [Movie]) {
        view?.hideLoading()
        
        if movies.isEmpty {
            view?.showEmptyState()
        } else {
            view?.showMovies(movies: movies)
        }
    }
    
    func fetchMoviesFailed(error: NetworkError) {
        view?.hideLoading()
        
        view?.showError(error: error.localizedDescription)
    }
}
