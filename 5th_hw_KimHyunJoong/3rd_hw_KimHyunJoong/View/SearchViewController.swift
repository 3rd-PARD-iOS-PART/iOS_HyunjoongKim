//
//  SearchViewController.swift
//  TabBar
//
//  Created by 김하람 on 2023/09/29.
//

import UIKit

class SearchViewController: UIViewController {
    
    let topSearchesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top Searches"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(TopSearchCell.self, forCellReuseIdentifier: "TopSearchCell")
        return tableView
    }()
    
    // api에서 불러온 popular movies 영화 데이터를 저장하는 배열
    var popularMovies: [MovieData] = []
    // 검색 결과에 따라 필터링된 영화 데이터를 저장하는 배열
    var filteredMovies: [MovieData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupViews()
        setupConstraints()
        
        setupSearchBar()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 영화 데이터를 가져오는 함수 호출
        fetchPopularMovies()
        setupTableViewHeader()
        
        filteredMovies = popularMovies
    }
    
    // 서치바 함수
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a show, movie, genre, e.t.c."
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a show, movie, genre, e.t.c.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        searchBar.searchTextField.layer.cornerRadius = 5
        searchBar.searchTextField.clipsToBounds = true
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = .none
        searchBar.updateHeight(height: 48)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .black
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
      
    func setupViews() {
        view.addSubview(tableView)
    }
      
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
      
    func setupTableViewHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        headerView.backgroundColor = .black
          
        topSearchesLabel.frame = CGRect(x: 16, y: 0, width: headerView.bounds.width - 32, height: headerView.bounds.height)
        headerView.addSubview(topSearchesLabel)
          
        tableView.tableHeaderView = headerView
    }
    
    func fetchPopularMovies() {
        MovieData.fetchPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.popularMovies = movies
                // 초기에는 filteredMovies에 모든 인기 영화 데이터 할당
                self?.filteredMovies = movies
                // 테이블 뷰 리로드
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch popular movies: \(error.localizedDescription)")
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 필터링된 영화 데이터의 개수만큼 행 반환
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopSearchCell", for: indexPath) as! TopSearchCell
        // 필터링된 영화 데이터에서 해당 인덱스의 영화 데이터 가져오기
        let movie = filteredMovies[indexPath.row]
        // 셀에 영화 데이터 설정
        cell.configure(with: movie)
        cell.selectionStyle = .none
        cell.backgroundColor = .darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101.5
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 5
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}

class TopSearchCell: UITableViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    let button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.background.backgroundColor = .clear
        configuration.image = UIImage(named: "playCircle")
        configuration.imagePadding = 15
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        configuration.baseForegroundColor = .black
            
        let btnPlay = UIButton(configuration: configuration)
        btnPlay.translatesAutoresizingMaskIntoConstraints = false
        return btnPlay
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
    func configure(with movie: MovieData) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: baseURL + posterPath)
            // 영화 포스터 이미지 다운로드 및 설정
            posterImageView.downloadImage(from: posterURL!)
        }
        
        // 영화 제목 설정
        titleLabel.text = movie.title
    }
}

extension UISearchBar {
    func updateHeight(height: CGFloat, radius: CGFloat = 8.0) {
        let image: UIImage? = UIImage.imageWithColor(color: UIColor.clear, size: CGSize(width: 1, height: height))
        setSearchFieldBackgroundImage(image, for: .normal)
        for subview in self.subviews {
            for subSubViews in subview.subviews {
                if #available(iOS 13.0, *) {
                    for child in subSubViews.subviews {
                        if let textField = child as? UISearchTextField {
                            textField.layer.cornerRadius = radius
                            textField.clipsToBounds = true
                        }
                    }
                    continue
                }
                if let textField = subSubViews as? UITextField {
                    textField.layer.cornerRadius = radius
                    textField.clipsToBounds = true
                }
            }
        }
    }
}

// 서치바 높이 조절 익스텐션
private extension UIImage {
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // 검색어가 비어있으면 모든 인기 영화 데이터로 설정
            filteredMovies = popularMovies
        } else {
            // 검색어가 있으면 검색어를 포함하는 영화 데이터만 필터링
            filteredMovies = popularMovies.filter { $0.title.range(of: searchText, options: .caseInsensitive) != nil }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        // 검색 취소 시 모든 인기 영화 데이터로 설정
        filteredMovies = popularMovies
        tableView.reloadData()
    }
}
