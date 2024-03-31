import UIKit

class ViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "netflix_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let tvShowsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TV Shows", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let moviesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let myListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let trendingNowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Trending Now"
        return label
    }()
    
    let trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Popular on Netflix"
        return label
    }()
    
    let popularTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(tvShowsButton)
        view.addSubview(moviesButton)
        view.addSubview(myListButton)
        view.addSubview(trendingNowLabel)
        view.addSubview(trendingCollectionView)
        view.addSubview(popularLabel)
        view.addSubview(popularTableView)
        
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
        
        popularTableView.dataSource = self
        popularTableView.delegate = self
        popularTableView.register(MovieTableCell.self, forCellReuseIdentifier: "MovieTableCell")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            
            tvShowsButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            tvShowsButton.trailingAnchor.constraint(equalTo: moviesButton.leadingAnchor, constant: -40),
            
            moviesButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            moviesButton.trailingAnchor.constraint(equalTo: myListButton.leadingAnchor, constant: -40),
            
            myListButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            myListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            trendingNowLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            trendingNowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            trendingCollectionView.topAnchor.constraint(equalTo: trendingNowLabel.bottomAnchor, constant: 16),
            trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            popularLabel.topAnchor.constraint(equalTo: trendingCollectionView.bottomAnchor, constant: 32),
            popularLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            popularTableView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 16),
            popularTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.configure()
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieTableCell
        cell.configure()
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
    
    func configure() {
        posterImageView.image = UIImage(named: "me")
    }
}

class MovieTableCell: UITableViewCell {
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func configure() {
        posterImageView.image = UIImage(named: "me")
    }
}
