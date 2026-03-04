import XCTest
@testable import MovieHub

final class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!
    
    override func setUp() {
        super.setUp()
        
        sut = HomePresenter()
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        
        sut.view = mockView
        sut.interactor = mockInteractor
        sut.router = mockRouter
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad_callsInteractorFetchMovies() {
        XCTAssertFalse(mockInteractor.fetchMoviesCalled)
        
        sut.viewDidLoad()
        
        XCTAssertTrue(mockInteractor.fetchMoviesCalled, "viewDidLoad çağrıldığında interactor.fetchMovies() çağrılmalı")
    }
    
    func test_fetchMoviesSuccess_callsViewShowMovies() {
        let movies = [
            Movie(id: 1, title: "Film 1", overview: nil, posterPath: nil, voteAverage: 7.5, releaseDate: nil),
            Movie(id: 2, title: "Film 2", overview: nil, posterPath: nil, voteAverage: 8.0, releaseDate: nil)
        ]
        
        sut.fetchMoviesSuccess(popular: movies, topRated: movies, upcoming: movies)
        
        XCTAssertTrue(mockView.showMoviesCalled, "Filmler başarıyla geldiğinde view.showMovies() çağrılmalı")
        XCTAssertEqual(mockView.popularMovies?.count, 2, "Popular filmler doğru sayıda olmalı")
        XCTAssertTrue(mockView.hideLoadingCalled, "Loading gizlenmeli")
    }
    
    func test_fetchMoviesFailed_callsViewShowError() {
        let error = NetworkError.noData
        
        sut.fetchMoviesFailed(error: error)
        
        XCTAssertTrue(mockView.showErrorCalled, "Hata olduğunda view.showError() çağrılmalı")
        XCTAssertNotNil(mockView.errorMessage, "Hata mesajı olmalı")
        XCTAssertTrue(mockView.hideLoadingCalled, "Loading gizlenmeli")
    }
    
    func test_didSelectMovie_callsRouterNavigateToDetail() {
        let movie = Movie(id: 1, title: "Test Film", overview: nil, posterPath: nil, voteAverage: 7.5, releaseDate: nil)
        
        sut.didSelectMovie(movie)
        
        XCTAssertTrue(mockRouter.navigateToDetailCalled, "Film tıklandığında router.navigateToDetail() çağrılmalı")
        XCTAssertEqual(mockRouter.selectedMovie?.id, 1, "Doğru film router'a gönderilmeli")
    }
    
    func test_fetchMoviesSuccess_withEmptyArray_stillCallsShowMovies() {
        let emptyMovies: [Movie] = []
        
        sut.fetchMoviesSuccess(popular: emptyMovies, topRated: emptyMovies, upcoming: emptyMovies)
        
        XCTAssertTrue(mockView.showMoviesCalled, "Boş array de showMovies çağrılmalı")
        XCTAssertEqual(mockView.popularMovies?.count, 0, "Boş array gönderilmeli")
    }
}

class MockHomeView: HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    var showMoviesCalled = false
    var showLoadingCalled = false
    var hideLoadingCalled = false
    var showErrorCalled = false
    
    var popularMovies: [Movie]?
    var topRatedMovies: [Movie]?
    var upcomingMovies: [Movie]?
    var errorMessage: String?
    
    func showLoading() {
        showLoadingCalled = true
    }
    
    func hideLoading() {
        hideLoadingCalled = true
    }
    
    func showMovies(popular: [Movie], topRated: [Movie], upcoming: [Movie]) {
        showMoviesCalled = true
        popularMovies = popular
        topRatedMovies = topRated
        upcomingMovies = upcoming
    }
    
    func showError(_ message: String) {
        showErrorCalled = true
        errorMessage = message
    }
}

class MockHomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterProtocol?
    
    var fetchMoviesCalled = false
    
    func fetchMovies() {
        fetchMoviesCalled = true
    }
}

class MockHomeRouter: HomeRouterProtocol {
    var navigateToDetailCalled = false
    var selectedMovie: Movie?
    
    func navigateToDetail(movie: Movie) {
        navigateToDetailCalled = true
        selectedMovie = movie
    }
}
