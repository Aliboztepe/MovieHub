import UIKit

class SplashRouter: SplashRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToHome() {
        let tabBarController = UITabBarController()
        let homeVC = HomeBuilder.build()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "home.tab".localized(),
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let searchVC = SearchBuilder.build()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(
            title: "search.tab".localized(),
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        tabBarController.viewControllers = [homeNav, searchNav]
        
        viewController?.view.window?.rootViewController = tabBarController
        viewController?.view.window?.makeKeyAndVisible()
    }
}
