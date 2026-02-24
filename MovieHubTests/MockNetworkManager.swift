import Foundation
import Combine
@testable import MovieHub

final class MockNetworkManager: NetworkManagerProtocol {
    
    var mockData: Any?
    var mockError: NetworkError?
    
    func fetch<T: Decodable>(endpoint: MovieEndpoint) -> AnyPublisher<T, NetworkError> {
        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        if let data = mockData as? T {
            return Just(data).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        }
        
        return Fail(error: NetworkError.noData).eraseToAnyPublisher()
    }
}
