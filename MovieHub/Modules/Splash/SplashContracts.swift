import UIKit

protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
    
    func showLoading()
    func hideLoading()
}

protocol SplashPresenterProtocol: AnyObject {
    var view: SplashViewProtocol? { get set }
    var interactor: SplashInteractorProtocol? { get set }
    var router: SplashRouterProtocol? { get set }
    
    func viewDidLoad()
    func appReady()
}

protocol SplashInteractorProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }

    func checkAppReady()
}

protocol SplashRouterProtocol: AnyObject {
    func navigateToHome()
}
