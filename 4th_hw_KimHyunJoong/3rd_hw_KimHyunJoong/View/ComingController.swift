import UIKit

class ComingController: UIViewController {
    
    // 테이블뷰 생성
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    // 개봉 예정 영화 데이터 저장할 배열 선언
    var upcomingMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setupNavigationBar()
        setupTableView()
        fetchUpcomingMovies()
    }
    
    // 내비게이션 바 타이틀과 이미지 설정 메서드
    func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Notifications"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        let notificationImage = UIImage(named: "Notification")
        let imageView = UIImageView(image: notificationImage)
        imageView.contentMode = .scaleAspectFit
        
        let titleView = UIView()
        titleView.addSubview(imageView)
        titleView.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // NavigationBar item constraint 조정
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)
        ])
        
        // titleView의 크기 설정
        titleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // 내비게이션바 타이틀 뷰 설정
        navigationItem.titleView = titleView
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .black
        
        // titleView의 위치 조정 (수평)
        navigationBarAppearance.titlePositionAdjustment = UIOffset(horizontal: -90, vertical: 0)
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    func setupTableView() {
        view.addSubview(tableView)

        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // 개봉 예정 영화 데이터 가져오기
    func fetchUpcomingMovies() {
        ApiCaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.upcomingMovies = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ComingController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return upcomingMovies.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = upcomingMovies[indexPath.section]
        cell.configure(with: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

class MovieCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let remindButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Remind")
        config.title = "Remind Me"
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 6
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Share")
        config.title = "Share"
        config.baseForegroundColor = .white
        config.imagePlacement = .top
        config.imagePadding = 6
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .black
        selectionStyle = .none

        contentView.addSubview(posterImageView)
        contentView.addSubview(remindButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(genreLabel)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([

            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 250),

            remindButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 30),
            remindButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 200),
            remindButton.widthAnchor.constraint(equalToConstant: 120),
            remindButton.heightAnchor.constraint(equalToConstant: 30),

            shareButton.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 30),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            shareButton.widthAnchor.constraint(equalToConstant: 80),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            
            releaseDateLabel.topAnchor.constraint(equalTo: remindButton.bottomAnchor, constant: 23),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 7),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            overviewLabel.heightAnchor.constraint(equalToConstant: 50),
            
            genreLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 5),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        // releaseDate 포맷 변경
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: movie.releaseDate) {
            dateFormatter.dateFormat = "MMMM d"
            let formattedDate = dateFormatter.string(from: date)
            releaseDateLabel.text = "Season 1 Coming \(formattedDate)"
        } else {
            releaseDateLabel.text = "Season 1 Coming"
        }
        
        // genreIDs를 장르 이름으로 변환
        let genreNames = movie.genreIDs.compactMap { getGenreName(for: $0) }.joined(separator: " • ")
        genreLabel.text = genreNames
        
        // 포스터 이미지 설정
        if let posterPath = movie.posterPath {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURL + posterPath)
            posterImageView.downloadImage(from: posterURL!)
        }
    }
    
    // Api에서 response로 가져온 genreID를 장르 이름으로 변환하는 메서드 -> TMDB에서 제공
    func getGenreName(for genreID: Int) -> String? {
        switch genreID {
        case 28: return "Action"
        case 12: return "Adventure"
        case 16: return "Animation"
        case 35: return "Comedy"
        case 80: return "Crime"
        case 99: return "Documentary"
        case 18: return "Drama"
        case 10751: return "Family"
        case 14: return "Fantasy"
        case 36: return "History"
        case 27: return "Horror"
        case 10402: return "Music"
        case 9648: return "Mystery"
        case 10749: return "Romance"
        case 878: return "Science Fiction"
        case 10770: return "TV Movie"
        case 53: return "Thriller"
        case 10752: return "War"
        case 37: return "Western"
        default: return nil
        }
    }
}

