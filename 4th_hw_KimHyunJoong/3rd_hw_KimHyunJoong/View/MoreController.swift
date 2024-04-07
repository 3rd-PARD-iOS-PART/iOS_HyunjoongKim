//
//  ThirdViewController.swift
//  TabBar
//
//  Created by 김하람 on 2023/09/29.
//

import UIKit


class MoreController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setUI()
    }
    
    func setUI(){
        let image: UIImageView = {
            let image1 = UIImageView()
            // systemImage의 크기를 조정하기 위해서는 symbolConfiguration을 지정해야 한다.
            let imageSize = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
            image1.translatesAutoresizingMaskIntoConstraints = false
            image1.image = UIImage(systemName: "figure.surfing", withConfiguration: imageSize)
            image1.tintColor = .white
            image1.contentMode = .scaleAspectFit
            return image1
        }()
        
        view.addSubview(image)
        
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

