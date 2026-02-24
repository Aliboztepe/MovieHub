import UIKit

enum Theme: String {
    case light
    case dark
    case system
}

final class ThemeManager {
    // MARK: - Singleton
    static let shared = ThemeManager()
    private init() {
        loadTheme()
    }
    
    // MARK: - Properties
    private(set) var currentTheme: Theme = .system
    private let userDefaults = UserDefaults.standard
    private let themeKey = "app_theme"
    
    // MARK: - Public Methods
    func setTheme(_ theme: Theme) {
        currentTheme = theme
        userDefaults.set(theme.rawValue, forKey: themeKey)
        applyTheme()
    }
    
    // MARK: - Private Methods
    private func loadTheme() {
        if let savedTheme = userDefaults.string(forKey: themeKey),
           let theme = Theme(rawValue: savedTheme) {
            currentTheme = theme
        }
        applyTheme()
    }
    
    private func applyTheme() {
        let style: UIUserInterfaceStyle
        
        switch currentTheme {
        case .light:
            style = .light
        case .dark:
            style = .dark
        case .system:
            style = .unspecified
        }
        
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = style
        }
    }
}
