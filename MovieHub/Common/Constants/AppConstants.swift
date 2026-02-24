import Foundation

enum AppConstants {
    // MARK: - Constants
    static let tmbdAPIKey = Secrets.apiKey
    static let tmbdBaseURL = "https://api.themoviedb.org/3"
    static let tmbdImageBaseURL = "https://image.tmdb.org/t/p"
    
    // MARK: - App Info
    static let appName = "MovieHub"
    static let appVersion = "1.0.0"
}

enum ImageSize: String {
    case small = "/w185"
    case medium = "/w342"
    case large = "/w500"
    case original = "/original"
}
