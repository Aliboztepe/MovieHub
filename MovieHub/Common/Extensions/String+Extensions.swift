import Foundation

extension String {
    
    // MARK: - Localization
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
