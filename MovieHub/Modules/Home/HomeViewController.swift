import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?

    private var popularMovies: [Movie] = []
    private var topRatedMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = DesignSystem.Colors.background
        table.separatorStyle = .none
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "home.title".localized()
        view.backgroundColor = DesignSystem.Colors.background
        
        view.addSubviews(tableView, activityIndicator)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        tableView.register(MovieCategoryCell.self, forCellReuseIdentifier: "MovieCategoryCell")
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }

    func showMovies(popular: [Movie], topRated: [Movie], upcoming: [Movie]) {
        self.popularMovies = popular
        self.topRatedMovies = topRated
        self.upcomingMovies = upcoming
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "common.error".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "common.ok".localized(), style: .default))
        present(alert, animated: true)
    }
    
    func didSelectMovie(_ movie: Movie) {
        presenter?.didSelectMovie(movie)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, MovieCategoryCellDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCategoryCell", for: indexPath)
                as? MovieCategoryCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case 0:
            cell.configure(with: popularMovies)
        case 1:
            cell.configure(with: topRatedMovies)
        case 2:
            cell.configure(with: upcomingMovies)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "home.popular".localized()
        case 1: return "home.topRated".localized()
        case 2: return "home.upcoming".localized()
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
