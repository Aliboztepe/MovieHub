import Foundation

class DetailInteractor: DetailInteractorProtocol {
    weak var presenter: DetailPresenterProtocol?
    
    func checkScreenReady() {
        presenter?.screenReady()
    }
}
