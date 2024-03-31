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
   
   let mainTableView: UITableView = {
       let tableView = UITableView()
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
   }
   
   func setupViews() {
       view.addSubview(logoImageView)
       view.addSubview(tvShowsButton)
       view.addSubview(moviesButton)
       view.addSubview(myListButton)
       view.addSubview(mainTableView)
       
       mainTableView.dataSource = self
       mainTableView.delegate = self
       mainTableView.register(MovieSectionCell.self, forCellReuseIdentifier: "MovieSectionCell")
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
           
           mainTableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
           mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
       ])
   }
}

extension ViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
       return sections.count
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSectionCell", for: indexPath) as! MovieSectionCell
       cell.sectionLabel.text = sections[indexPath.section]
       return cell
   }
}

extension ViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 240
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
       
       contentView.addSubview(sectionLabel)
       contentView.addSubview(movieCollectionView)
       
       movieCollectionView.dataSource = self
       movieCollectionView.delegate = self
       movieCollectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCollectionCell")
       
       setupConstraints()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func setupConstraints() {
       NSLayoutConstraint.activate([
           sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
           sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           
           movieCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 16),
           movieCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
           movieCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
           movieCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
           movieCollectionView.heightAnchor.constraint(equalToConstant: 180)
       ])
   }
}

extension MovieSectionCell: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 10
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
       cell.configure()
       return cell
   }
}

extension MovieSectionCell: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
   
   func configure() {
       posterImageView.image = UIImage(named: "me")
   }
}
