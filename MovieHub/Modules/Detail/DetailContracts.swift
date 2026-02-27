import UIKit

protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    func showMovieInformation()
}

protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    
    func viewDidLoad()
    func screenReady()
}

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
    
    func checkScreenReady()
}

protocol DetailRouterProtocol: AnyObject {
    func navigateBack()
}
