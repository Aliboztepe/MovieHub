import UIKit

class SearchRouter: SearchRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToDetail(movie: Movie) {
        let detailVC = DetailBuilder.build(with: movie)
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
