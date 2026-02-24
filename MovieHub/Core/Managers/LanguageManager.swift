import Foundation

enum Language: String {
    case turkish = "tr"
    case english = "en"
    
    var displayName: String {
        switch self {
        case .turkish: return "Türkçe"
        case .english: return "English"
        }
    }
}

final class LanguageManager {
    static let shared = LanguageManager()
    private init() {
        loadLanguage()
    }
    
    private(set) var currentLanguage: Language = .english
    private let userDefaults = UserDefaults.standard
    private let languageKey = "app_language"
    
    func setLanguage(_ language: Language) {
        currentLanguage = language
        userDefaults.set(currentLanguage.rawValue, forKey: languageKey)
        applyLanguage()
    }
    
    private func loadLanguage() {
        if let savedLanguage = userDefaults.string(forKey: languageKey),
           let language = Language(rawValue: savedLanguage) {
            currentLanguage = language
        }
        applyLanguage()
    }
    
    private func applyLanguage() {
        UserDefaults.standard.set([currentLanguage.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}
