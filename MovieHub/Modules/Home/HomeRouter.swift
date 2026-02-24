import UIKit

class HomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToDetail(movie: Movie) {
        print("Navigate to detail: \(movie.title)")
    }
}
