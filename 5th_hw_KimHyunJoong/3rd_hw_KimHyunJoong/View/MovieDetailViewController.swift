import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: MovieData?
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "X"), for: .normal)
        return button
    }()
    
    let airPlayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "detailAirPlay"), for: .normal)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "S5:E10 Nothing Remains The Same"
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let playButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailPlayButton"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let downloadButton: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailDownloadButton"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let netflixLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "netflix_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let seriesImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Series"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let barImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let listImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailList"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let rateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailRate"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let shareImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailShare"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let menuImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailMenu"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let seasonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailSeason"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let episodeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    let detailPlayImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailPlay"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(closeButton)
        contentView.addSubview(airPlayButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(playButton)
        contentView.addSubview(netflixLogoImageView)
        contentView.addSubview(seriesImageView)
        contentView.addSubview(barImageView)
        contentView.addSubview(downloadButton)
        contentView.addSubview(listImageView)
        contentView.addSubview(rateImageView)
        contentView.addSubview(shareImageView)
        contentView.addSubview(menuImageView)
        contentView.addSubview(seasonImageView)
        contentView.addSubview(episodeStackView)
        contentView.addSubview(detailPlayImageView)
        
        setupConstraints()
        
        configureView()
        addEpisodeViews()
        
        // 닫기 버튼에 대한 액션 추가
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 215),
            
            detailPlayImageView.centerXAnchor.constraint(equalTo: posterImageView.centerXAnchor),
            detailPlayImageView.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            detailPlayImageView.widthAnchor.constraint(equalToConstant: 50),
            detailPlayImageView.heightAnchor.constraint(equalToConstant: 50),
            
            netflixLogoImageView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            netflixLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            netflixLogoImageView.widthAnchor.constraint(equalToConstant: 30),
            netflixLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            
            seriesImageView.centerYAnchor.constraint(equalTo: netflixLogoImageView.centerYAnchor),
            seriesImageView.leadingAnchor.constraint(equalTo: netflixLogoImageView.trailingAnchor, constant: 2),
            seriesImageView.widthAnchor.constraint(equalToConstant: 50),
            seriesImageView.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: netflixLogoImageView.bottomAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            barImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            barImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            barImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -140),
            barImageView.heightAnchor.constraint(equalToConstant: 15),
            barImageView.widthAnchor.constraint(equalToConstant: 15),
            
            playButton.topAnchor.constraint(equalTo: barImageView.bottomAnchor, constant: 16),
            playButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 400),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            
            downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 8),
            downloadButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 400),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            
            releaseDateLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            
            overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            
            closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            
            airPlayButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            airPlayButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            airPlayButton.widthAnchor.constraint(equalToConstant: 24),
            airPlayButton.heightAnchor.constraint(equalToConstant: 24),
            
            listImageView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            listImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            listImageView.widthAnchor.constraint(equalToConstant: 45),
            listImageView.heightAnchor.constraint(equalToConstant: 50),
            
            rateImageView.centerYAnchor.constraint(equalTo: listImageView.centerYAnchor),
            rateImageView.leadingAnchor.constraint(equalTo: listImageView.trailingAnchor, constant: 40),
            rateImageView.widthAnchor.constraint(equalToConstant: 45),
            rateImageView.heightAnchor.constraint(equalToConstant: 50),
            
            shareImageView.centerYAnchor.constraint(equalTo: listImageView.centerYAnchor),
            shareImageView.leadingAnchor.constraint(equalTo: rateImageView.trailingAnchor, constant: 40),
            shareImageView.widthAnchor.constraint(equalToConstant: 45),
            shareImageView.heightAnchor.constraint(equalToConstant: 50),
            
            menuImageView.topAnchor.constraint(equalTo: listImageView.bottomAnchor, constant: 16),
            menuImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            menuImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            menuImageView.heightAnchor.constraint(equalToConstant: 35),
            
            seasonImageView.topAnchor.constraint(equalTo: menuImageView.bottomAnchor, constant: 16),
            seasonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            seasonImageView.widthAnchor.constraint(equalToConstant: 80),
            seasonImageView.heightAnchor.constraint(equalToConstant: 17),
            
            episodeStackView.topAnchor.constraint(equalTo: seasonImageView.bottomAnchor, constant: 16),
            episodeStackView.leadingAnchor.constraint(equalTo: seasonImageView.leadingAnchor),
            episodeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            episodeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureView() {
        guard let movie = movie else { return }
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: baseURL + posterPath)
            posterImageView.downloadImage(from: posterURL!)
        }
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
    }
    
    func addEpisodeViews() {
        let episodes = [
            ("Game Changer", "37m", "movie1", "Flying high: Chrishell reveals her latest love - Jason. In LA, the agents get real about the relationship while Christine readies her return."),
            ("The Jade Wolf", "41m", "movie2", "Flying high: Chrishell reveals her latest love - Jason. In LA, the agents get real about the relationship while Christine readies her return."),
            ("Into the Woods", "44m", "movie3", "Flying high: Chrishell reveals her latest love - Jason. In LA, the agents get real about the relationship while Christine readies her return."),
            ("The Chalice", "42m", "movie4", "Flying high: Chrishell reveals her latest love - Jason. In LA, the agents get real about the relationship while Christine readies her return."),
            ("The Brink", "40m", "movie5", "Flying high: Chrishell reveals her latest love - Jason. In LA, the agents get real about the relationship while Christine readies her return.")
        ]
        for episode in episodes {
            let episodeView = EpisodeView()
            episodeView.configure(title: episode.0, duration: episode.1, imageName: episode.2, description: episode.3)
            // 에피소드 뷰를 스택뷰에 추가
            episodeStackView.addArrangedSubview(episodeView)
        }
    }
    
    // 닫기 버튼 탭 시 호출되는 메서드
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

// 에피소드 뷰를 나타내는 커스텀 뷰
class EpisodeView: UIView {
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let playImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "episodePlay"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let detailEpisodePlayImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "detailEpisodePlay"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 에피소드 뷰에 UI 요소들 추가
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(durationLabel)
        addSubview(playImageView)
        addSubview(descriptionLabel)
        addSubview(detailEpisodePlayImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 65),
            
            detailEpisodePlayImageView.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor),
            detailEpisodePlayImageView.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            detailEpisodePlayImageView.widthAnchor.constraint(equalToConstant: 30),
            detailEpisodePlayImageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            durationLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 16),
            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            playImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 24),
            playImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    // 에피소드 뷰 구성
    func configure(title: String, duration: String, imageName: String, description: String) {
        titleLabel.text = title
        durationLabel.text = duration
        thumbnailImageView.image = UIImage(named: imageName)
        descriptionLabel.text = description
    }
}
