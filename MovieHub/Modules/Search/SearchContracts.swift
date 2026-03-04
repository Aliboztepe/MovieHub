import Foundation

protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    
    func showMovies(movies: [Movie])
    func showLoading()
    func hideLoading()
    func showError(error: String)
    func showEmptyState()
}

protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    
    func viewDidLoad()
    func searchMovies(query: String)
    func didSelectMovie(movie: Movie)
    func fetchMoviesSuccess(movies: [Movie])
    func fetchMoviesFailed(error: NetworkError)
}

protocol SearchInteractorProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    
    func searchMovies(query: String)
}

protocol SearchRouterProtocol: AnyObject {
    func navigateToDetail(movie: Movie)
}
