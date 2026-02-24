import UIKit

enum DesignSystem {
    
    // MARK: - Colors
    enum Colors {
        static let primary = UIColor.systemBlue
        static let secondary = UIColor.systemIndigo
        static let background = UIColor.systemBackground
        static let secondaryBackground = UIColor.secondarySystemBackground
        static let text = UIColor.label
        static let secondaryText = UIColor.secondaryLabel
        
        static let error = UIColor.systemRed
        static let success = UIColor.systemGreen
        static let warning = UIColor.systemOrange
    }
    
    // MARK: - Fonts
    enum Fonts {
        static let largeTitle = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let title = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let headline = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let body = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let callout = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let caption = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let footnote = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 24
    }
}
