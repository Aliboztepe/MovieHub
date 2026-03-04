import UIKit

class SearchViewController: UIViewController, SearchViewProtocol {
    var presenter: SearchPresenterProtocol?
    
    private var movies: [Movie] = []
    private var searchTimer: Timer?
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "search.placeholder".localized()
        return search
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "search.empty".localized()
        label.font = DesignSystem.Fonts.body
        label.textColor = DesignSystem.Colors.secondaryText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = DesignSystem.Colors.background

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        searchController.searchResultsUpdater = self
        
        view.addSubviews(tableView, activityIndicator, label)
        navigationItem.searchController = searchController
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func showMovies(movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
        tableView.isHidden = false
        label.isHidden = true
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        label.isHidden = true
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "common.error".localized(), message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "common.ok".localized(), style: .default))
        present(alert, animated: true)
    }
    
    func showEmptyState() {
        label.isHidden = false
        tableView.isHidden = true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        presenter?.didSelectMovie(movie: movie)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            showEmptyState()
            return
        }
        
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.presenter?.searchMovies(query: query)
        }
        
        
    }
}
