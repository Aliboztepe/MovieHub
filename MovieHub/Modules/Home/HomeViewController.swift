import UIKit

class HomeViewController: UIViewController, HomeViewProtocol {
    weak var presenter: HomePresenterProtocol?

    private var popularMovies: [Movie] = []
    private var topRatedMovies: [Movie] = []
    private var upcomingMovies: [Movie] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = DesignSystem.Colors.background
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = "home.title".localized()
        view.backgroundColor = DesignSystem.Colors.background
        
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(MovieCategoryCell.self, forCellReuseIdentifier: "MovieCategoryCell")
    }
    
    func showLoading() {
        
    }

    func hideLoading() {
        
    }

    func showMovies(popular: [Movie], topRated: [Movie], upcoming: [Movie]) {
        self.popularMovies = popular
        self.topRatedMovies = topRated
        self.upcomingMovies = upcoming
        tableView.reloadData()
    }

    func showError(_ message: String) {
        print("Error: \(message)")
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
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
