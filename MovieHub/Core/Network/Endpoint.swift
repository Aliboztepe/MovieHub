import Foundation
import Alamofire

enum MovieEndpoint {
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case detail(id: Int)
    case search(query: String, page: Int)
    
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        case .detail(let id):
            return "/movie/\(id)"
        case .search:
            return "/search/movie"
        }
    }
    
    var parameters: [String: Any]? {
        let language = LanguageManager.shared.currentLanguage.rawValue
        
        var params: [String: Any] = ["api_key": AppConstants.tmbdAPIKey]
        
        switch self {
        case .popular(let page):
            params["page"] = page
            params["language"] = language
            return params
            
        case .topRated(let page):
            params["page"] = page
            params["language"] = language
            return params
            
        case .upcoming(let page):
            params["page"] = page
            params["language"] = language
            return params
            
        case .detail:
            params["language"] = language
            return params
            
        case .search(let query, let page):
            params["query"] = query
            params["page"] = page
            params["language"] = language
            return params
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var fullURL: String {
        return "\(AppConstants.tmbdBaseURL)\(self.path)"
    }
}
