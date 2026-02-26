import Foundation

class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashViewProtocol?
    var interactor: SplashInteractorProtocol?
    var router: SplashRouterProtocol?
    
    func viewDidLoad() {
        interactor?.checkAppReady()
    }
    
    func appReady() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.router?.navigateToHome()
        }
    }
}
