import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let urlString = AppConstants.tmbdImageBaseURL + ImageSize.large.rawValue + posterPath
        
        return URL(string: urlString)
    }
}

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
