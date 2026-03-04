import Foundation
import Combine

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
    
    private let networkManager: NetworkManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func searchMovies(query: String) {
        let publisher: AnyPublisher<MovieResponse, NetworkError> = networkManager.fetch(endpoint: MovieEndpoint.search(query: query, page: 1))
        
        publisher.sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.presenter?.fetchMoviesFailed(error: error)
                }
                
            },
            receiveValue: { [weak self] response in
                self?.presenter?.fetchMoviesSuccess(movies: response.results)
            }
        ).store(in: &cancellables)
    }
}
