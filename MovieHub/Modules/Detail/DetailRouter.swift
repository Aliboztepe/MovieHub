import UIKit

class DetailRouter: DetailRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateBack() {
        print("Navigate")
    }
}
