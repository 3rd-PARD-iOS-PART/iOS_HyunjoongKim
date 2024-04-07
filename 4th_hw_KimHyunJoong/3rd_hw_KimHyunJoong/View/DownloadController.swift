//
//  DownloadController.swift
//  TabBar
//
//  Created by 김하람 on 2023/09/29.
//

import UIKit


class DownloadController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setUI()
    }
    
    func setUI(){
        let label1: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "HEART"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
            return label
        }()
//        let image: UIImageView = {
//            let image1 = UIImageView()
//            // systemImage의 크기를 조정하기 위해서는 symbolConfiguration을 지정해야 한다.
//            let imageSize = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
//            image1.translatesAutoresizingMaskIntoConstraints = false
//            image1.image = UIImage(systemName: "heart.fill", withConfiguration: imageSize)
//            image1.tintColor = .white
//            image1.contentMode = .scaleAspectFit
//            return image1
//        }()
//
//        view.addSubview(image)
        view.addSubview(label1)
        
        
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


