import Foundation
import Combine

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(endpoint: MovieEndpoint) -> AnyPublisher<T, NetworkError>
}
