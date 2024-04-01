//
//  SearchViewController.swift
//  TabBar
//
//  Created by 김하람 on 2023/09/29.
//

import UIKit


class SearchViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        setUI()
    }
    
    func setUI(){
        let label1: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "북한군 김현중"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
            return label
        }()
        
        let image: UIImageView = {
            let image1 = UIImageView()
            image1.translatesAutoresizingMaskIntoConstraints = false
            image1.image = UIImage(named: "Me")
            image1.contentMode = .scaleAspectFit
            return image1
        }()
        
        view.addSubview(label1)
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
