import Foundation
import Combine

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    
    private let networkManager: NetworkManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() {
        let popularPublisher: AnyPublisher<MovieResponse, NetworkError> = networkManager
            .fetch(endpoint: MovieEndpoint.popular(page: 1))
        let topRatedPublisher: AnyPublisher<MovieResponse, NetworkError> = networkManager
            .fetch(endpoint: MovieEndpoint.topRated(page: 1))
        let upcomingPublisher: AnyPublisher<MovieResponse, NetworkError> = networkManager
            .fetch(endpoint: MovieEndpoint.upcoming(page: 1))
        
        Publishers.Zip3(popularPublisher, topRatedPublisher, upcomingPublisher)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.presenter?.fetchMoviesFailed(error: error)
                }
            }, receiveValue: { [weak self] (popular, topRated, upcoming) in
                self?.presenter?.fetchMoviesSuccess(popular: popular.results, topRated: topRated.results, upcoming: upcoming.results)
            }).store(in: &cancellables)
    }
}
