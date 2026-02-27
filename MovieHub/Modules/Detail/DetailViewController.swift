import UIKit
import Kingfisher

class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    var selectedMovie: Movie?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = DesignSystem.Colors.secondaryBackground
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Fonts.body
        label.textColor = DesignSystem.Colors.text
        label.numberOfLines = 1
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Fonts.body
        label.textColor = DesignSystem.Colors.text
        label.numberOfLines = 1
        return label
    }()
    
    private let overViewTextView: UITextView = {
        let textView = UITextView()
        textView.font = DesignSystem.Fonts.body
        textView.textColor = DesignSystem.Colors.text
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        title = selectedMovie?.title ?? "detail.title".localized()
        view.backgroundColor = DesignSystem.Colors.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(posterImageView, voteAverageLabel, releaseDateLabel, overViewTextView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        overViewTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            posterImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.5),
            
            voteAverageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            voteAverageLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 50),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: voteAverageLabel.leadingAnchor),
            releaseDateLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 20),
            
            overViewTextView.leadingAnchor.constraint(equalTo: releaseDateLabel.leadingAnchor),
            overViewTextView.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 50),
            overViewTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            overViewTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
    
    func showMovieInformation() {
        guard let movie = selectedMovie else { return }
        
        posterImageView.image = nil
        
        if let posterURL = movie.posterURL {
            posterImageView.kf.setImage(
                with: posterURL,
                placeholder: nil,
                options: [.transition(.fade(0.2))],
                completionHandler: nil
            )
        }

        voteAverageLabel.text = "\("detail.vote".localized()): ⭐ \(String(format: "%.2f", movie.voteAverage))"
        
        if let releaseDate = movie.releaseDate {
            releaseDateLabel.text = "\("detail.date".localized()): 📅 \(releaseDate)"
        }
        
        if let overview = movie.overview {
            overViewTextView.text = "\(overview)"
        }
    }
}
