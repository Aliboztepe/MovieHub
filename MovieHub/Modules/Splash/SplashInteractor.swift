import Foundation

class SplashInteractor: SplashInteractorProtocol {
    weak var presenter: SplashPresenterProtocol?
    
    func checkAppReady() {
        presenter?.appReady()
    }
}
