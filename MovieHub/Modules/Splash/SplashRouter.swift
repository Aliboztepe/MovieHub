import UIKit

class SplashRouter: SplashRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToHome() {
        let homeVC = HomeBuilder.build()
        let navigationController = UINavigationController(rootViewController: homeVC)
        
        viewController?.view.window?.rootViewController = navigationController
        viewController?.view.window?.makeKeyAndVisible()
    }
}
