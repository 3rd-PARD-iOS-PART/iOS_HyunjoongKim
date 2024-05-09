// 김현중

import UIKit

class HomeViewController: UIViewController {
   
    // 로고 이미지 뷰 생성
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "netflix_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
   
    // "TV Shows" 버튼 생성
    let tvShowsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TV Shows", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
   
    // "Movies" 버튼 생성
    let moviesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
   
    // "My List" 버튼 생성
    let myListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
   
    // 메인 테이블 뷰 생성
    let mainTableView: UITableView = {
        let tableView = UITableView()
        //전체화면 활용
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
   }()
   
    // cell들의 section의 title들을 배열에 선언
    let sections = ["Now Playing Movies", "Popular Movies", "Top Rated Movies", "Upcoming Movies"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .black
       
        setupViews()
        setupConstraints()
       
        mainTableView.backgroundColor = .black
        // 구분선 색
        mainTableView.separatorColor = .clear
        // 스크롤 인디케이터 하얀색
        mainTableView.indicatorStyle = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        mainTableView.register(FeaturedSectionCell.self, forCellReuseIdentifier: "FeaturedSectionCell")
    }
   
    // 뷰 계층 구조 설정
    func setupViews() {
        view.addSubview(mainTableView)
        mainTableView.addSubview(logoImageView)
        mainTableView.addSubview(tvShowsButton)
        mainTableView.addSubview(moviesButton)
        mainTableView.addSubview(myListButton)
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(MovieSectionCell.self, forCellReuseIdentifier: "MovieSectionCell")
    }
   
    // 오토레이아웃 설정
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: mainTableView.topAnchor, constant: 50),
            logoImageView.leadingAnchor.constraint(equalTo: mainTableView.leadingAnchor, constant: 0),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
           
            tvShowsButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            tvShowsButton.trailingAnchor.constraint(equalTo: moviesButton.leadingAnchor, constant:  -40),
           
            moviesButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            moviesButton.trailingAnchor.constraint(equalTo: myListButton.leadingAnchor, constant: -40),
           
            myListButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            myListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
 }

extension HomeViewController: UITableViewDataSource {
    // 섹션 개수 반환
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count + 1 // Featured 섹션 포함
    }
   
    // 각 섹션의 행 개수 변환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    // 각 섹션 셀 생성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedSectionCell", for: indexPath) as! FeaturedSectionCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSectionCell", for: indexPath) as! MovieSectionCell
            cell.sectionLabel.text = sections[indexPath.section - 1]
            
            // 섹션에 따라 적절한 API 호출 메서드 선택
            let fetchMoviesMethod: ((@escaping (Result<[MovieData], Error>) -> Void) -> Void)
            switch indexPath.section {
            case 1:
                fetchMoviesMethod = MovieData.fetchNowPlayingMovies
            case 2:
                fetchMoviesMethod = MovieData.fetchPopularMovies
            case 3:
                fetchMoviesMethod = MovieData.fetchTopRatedMovies
            case 4:
                fetchMoviesMethod = MovieData.fetchMovies
            default:
                return cell
            }
            
            // 선택된 API 호출 메서드를 사용하여 영화 데이터 가져오기
            fetchMoviesMethod { result in
                switch result {
                case .success(let movieData):
                    DispatchQueue.main.async {
                        cell.data = movieData
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    // 각 행의 높이 반환
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            // 첫 번째 섹션의 높이
            return 500
        } else {
            // 나머지 섹션의 높이
            return 240
        }
    }
}

class FeaturedSectionCell: UITableViewCell {

    let featuredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        let featuredImageView = UIImageView(image: UIImage(named: "movie35"))
        featuredImageView.translatesAutoresizingMaskIntoConstraints = false
        featuredImageView.contentMode = .scaleAspectFill
        featuredImageView.clipsToBounds = true
        featuredImageView.backgroundColor = .black
        view.addSubview(featuredImageView)
        
        // "MyList" 버튼 생성
        let button1: UIButton = {
            // configuration: Button안 image, title 공존 및 기타 설정을 위함
            var configuration = UIButton.Configuration.filled()
            configuration.background.backgroundColor = .clear
            configuration.title = "MyList"
            configuration.image = UIImage(named: "plus")
            configuration.imagePadding = 1
            configuration.titlePadding = 1
            // 이미지를 타이틀 위에 배치
            configuration.imagePlacement = .top
            // 버튼 내용 삽입 여백 설정
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
            let btnMyList = UIButton(configuration: configuration)
            btnMyList.setTitleColor(.white, for: .normal)
            btnMyList.titleLabel?.font = UIFont.systemFont(ofSize: 13.64, weight: .regular)
               
            btnMyList.translatesAutoresizingMaskIntoConstraints = false
            return btnMyList
        }()
            
        // "Play" 버튼 생성
        let button2: UIButton = {
            var configuration = UIButton.Configuration.filled()
            configuration.background.backgroundColor = UIColor.lightGray
            configuration.title = "Play"
            configuration.image = UIImage(named: "play")
            configuration.imagePadding = 15
            configuration.titlePadding = 15
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            configuration.baseForegroundColor = .black
                
            let btnPlay = UIButton(configuration: configuration)
            btnPlay.titleLabel?.font = UIFont.systemFont(ofSize: 13.64, weight: .heavy)
            
            btnPlay.translatesAutoresizingMaskIntoConstraints = false
            return btnPlay
        }()
            
        // "Info" 버튼 생성
        let button3: UIButton = {
            var configuration = UIButton.Configuration.filled()
            configuration.background.backgroundColor = .clear
            configuration.title = "Info"
            configuration.image = UIImage(named: "info")
            configuration.imagePadding = 1
            configuration.titlePadding = 1
            configuration.imagePlacement = .top
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
            let btnInfo = UIButton(configuration: configuration)
            btnInfo.setTitleColor(.white, for: .normal)
            btnInfo.titleLabel?.font = UIFont.systemFont(ofSize: 13.64, weight: .regular)
               
            btnInfo.translatesAutoresizingMaskIntoConstraints = false
            return btnInfo
        }()
        
        view.addSubview(button1)
      
        view.addSubview(button2)
 
        view.addSubview(button3)
            
        
        NSLayoutConstraint.activate([
            featuredImageView.topAnchor.constraint(equalTo: view.topAnchor),
            featuredImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            featuredImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            featuredImageView.heightAnchor.constraint(equalToConstant: 430),
            
            button1.topAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            button1.widthAnchor.constraint(equalToConstant: 60),
            button1.heightAnchor.constraint(equalToConstant: 50),
            
            button2.topAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: 16),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.widthAnchor.constraint(equalToConstant: 130),
            button2.heightAnchor.constraint(equalToConstant: 50),
            
            button3.topAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: 16),
            button3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            button3.widthAnchor.constraint(equalToConstant: 50),
            button3.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(featuredView)
        contentView.backgroundColor = .black
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            featuredView.topAnchor.constraint(equalTo: contentView.topAnchor),
            featuredView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featuredView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}

class MovieSectionCell: UITableViewCell {
   
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    var data: [MovieData] = [] {
        didSet {
            // 데이터가 변경되면 컬렉션 뷰 리로드
            movieCollectionView.reloadData()
        }
    }
    
    var sectionIndex: Int = 0
    
    func configure(with sectionIndex: Int, movies: [MovieData]) {
        self.sectionIndex = sectionIndex
        
        let startIndex = sectionIndex * 5 % movies.count
        let endIndex = (startIndex + 5) % movies.count
        data = endIndex > startIndex ? Array(movies[startIndex..<endIndex]) : Array(movies[startIndex..<movies.count] + movies[0..<endIndex])
    }
   
    let movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        backgroundColor = .black
       
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .black
        self.selectedBackgroundView = selectedBackgroundView
       
        contentView.addSubview(sectionLabel)
        contentView.addSubview(movieCollectionView)
       
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        movieCollectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier:  "MovieCollectionCell")
       
        setupConstraints()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           
            movieCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 16),
            movieCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
}

extension MovieSectionCell: UICollectionViewDataSource {
    // 섹션별 항목 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->  Int {
        return data.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 재사용 가능한 셀 가져오기
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        // 셀에 데이터 전달하여 구성
        cell.configure(with: data[indexPath.item])
        return cell
    }
}

extension MovieSectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:  UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기 설정
        return CGSize(width: 120, height: 180)
    }
}

extension UIImageView {
    func downloadImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}


class MovieCollectionCell: UICollectionViewCell {
   
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        backgroundColor = .black
       
        contentView.addSubview(posterImageView)
       
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // 데이터를 전달받아 포스터 이미지 뷰 구성
    func configure(with movie: MovieData) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: baseURL + posterPath)
            posterImageView.downloadImage(from: posterURL!)
        }
    }
}
