import Foundation
import Alamofire
import Combine

final class NetworkManager: NetworkManagerProtocol {
    func fetch<T: Decodable>(endpoint: MovieEndpoint) -> AnyPublisher<T, NetworkError> {
        guard let url = URL(string: endpoint.fullURL) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return AF.request(
            url,
            method: endpoint.method,
            parameters: endpoint.parameters
        )
        .publishDecodable(type: T.self)
        .value()
        .mapError { error -> NetworkError in
            if let responseCode = error.responseCode {
                if responseCode == 401 {
                    return NetworkError.unauthorized
                }
                return NetworkError.serverError(statusCode: responseCode)
            }
            return NetworkError.unknown(error)
        }
        .eraseToAnyPublisher()
    }
}
