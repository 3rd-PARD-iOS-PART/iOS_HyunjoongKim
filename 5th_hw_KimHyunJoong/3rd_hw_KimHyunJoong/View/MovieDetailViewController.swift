//
//  File.swift
//  3rd_hw_KimHyunJoong
//
//  Created by 김현중 on 4/14/24.
//
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
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(posterImageView)
        view.addSubview(closeButton)
        view.addSubview(airPlayButton)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(playButton)
        view.addSubview(netflixLogoImageView)
        view.addSubview(seriesImageView)
        view.addSubview(barImageView)
        view.addSubview(downloadButton)
        
        setupConstraints()
        
        configureView()
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 215),
            
            netflixLogoImageView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            netflixLogoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            netflixLogoImageView.widthAnchor.constraint(equalToConstant: 30),
            netflixLogoImageView.heightAnchor.constraint(equalToConstant: 30),
            
            seriesImageView.centerYAnchor.constraint(equalTo: netflixLogoImageView.centerYAnchor),
            seriesImageView.leadingAnchor.constraint(equalTo: netflixLogoImageView.trailingAnchor, constant: 2),
            seriesImageView.widthAnchor.constraint(equalToConstant: 50),
            seriesImageView.heightAnchor.constraint(equalToConstant: 10),
            
            titleLabel.topAnchor.constraint(equalTo: netflixLogoImageView.bottomAnchor, constant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            barImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            barImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            barImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140),
            barImageView.heightAnchor.constraint(equalToConstant: 15),
            barImageView.widthAnchor.constraint(equalToConstant: 15),
            
            playButton.topAnchor.constraint(equalTo: barImageView.bottomAnchor, constant: 16),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 400),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            
            downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 8),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 400),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            
            overviewLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            
            airPlayButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            airPlayButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            airPlayButton.widthAnchor.constraint(equalToConstant: 24),
            airPlayButton.heightAnchor.constraint(equalToConstant: 24),
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
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}