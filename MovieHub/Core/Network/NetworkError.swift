import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unauthorized
    case unknown(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "error.invalidURL".localized()
        case .noData:
            return "error.noData".localized()
        case .decodingError:
            return "error.decodingError".localized()
        case .serverError(let statusCode):
            return String(format: "error.serverError".localized(), statusCode)
        case .unauthorized:
            return "error.unauthorized".localized()
        case .unknown:
            return "error.unknown".localized()
        }
    }
}
