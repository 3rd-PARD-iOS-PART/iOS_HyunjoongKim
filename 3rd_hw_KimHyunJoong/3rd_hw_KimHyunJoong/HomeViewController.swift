import UIKit

class HomeViewController: UIViewController {
   
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "netflix_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
   
    let tvShowsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("TV Shows", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
   
    let moviesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
   
    let myListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("My List", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
   
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
   }()
   
    let sections = ["Popular on Netflix", "Trending Now", "Top 10 Nigeria Today", "My List", "African Movies", "Nollywood Movies & TV"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .black
       
        setupViews()
        setupConstraints()
       
        mainTableView.backgroundColor = .black
        mainTableView.separatorColor = .clear
        mainTableView.indicatorStyle = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        mainTableView.register(FeaturedSectionCell.self, forCellReuseIdentifier: "FeaturedSectionCell")
    }
   
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedSectionCell", for: indexPath) as! FeaturedSectionCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSectionCell", for: indexPath) as! MovieSectionCell
            cell.sectionLabel.text = sections[indexPath.section - 1]
            cell.data = MockData.modeling[indexPath.section - 1]
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 500
        } else {
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
        
  
       
        
        let button1: UIButton = {
            // configuration: Button안 image, title 공존 및 기타 설정을 위함
            var configuration = UIButton.Configuration.filled()
            configuration.background.backgroundColor = .clear
            configuration.title = "MyList"
            configuration.image = UIImage(named: "plus")
            configuration.imagePadding = 1
            configuration.titlePadding = 1
            configuration.imagePlacement = .top
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
            let btnMyList = UIButton(configuration: configuration)
            btnMyList.setTitleColor(.white, for: .normal)
            btnMyList.titleLabel?.font = UIFont.systemFont(ofSize: 13.64, weight: .regular)
               
            btnMyList.translatesAutoresizingMaskIntoConstraints = false
            return btnMyList
        }()
            
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
    
    var data: [MockData] = [] {
        didSet {
            movieCollectionView.reloadData()
        }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->  Int {
        return data.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        cell.configure(with: data[indexPath.item])
        return cell
    }
}

extension MovieSectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:  UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 180)
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
   
    func configure(with data: MockData) {
        posterImageView.image = UIImage(named: data.imageName)
    }
}
