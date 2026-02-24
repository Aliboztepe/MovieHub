import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
    func showMovies(popular: [Movie], topRated: [Movie], upcoming: [Movie])
    func showError(_ message: String)
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func viewDidLoad()
    func didSelectMovie(_ movie: Movie)
    func fetchMoviesSuccess(popular: [Movie], topRated: [Movie], upcoming: [Movie])
    func fetchMoviesFailed(error: NetworkError)
}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func fetchMovies()
}

protocol HomeRouterProtocol: AnyObject {
    func navigateToDetail(movie: Movie)
}
