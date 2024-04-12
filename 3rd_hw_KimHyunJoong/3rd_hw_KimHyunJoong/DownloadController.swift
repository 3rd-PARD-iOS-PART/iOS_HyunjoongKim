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
            label.text = "Movies and TV shows that you"
            label.textColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
            return label
        }()
        
        let label2: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "download appear here."
            label.textColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
            return label
        }()
        
        let image: UIImage = {
            
        }

        view.addSubview(label2)
        
        
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label1.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


