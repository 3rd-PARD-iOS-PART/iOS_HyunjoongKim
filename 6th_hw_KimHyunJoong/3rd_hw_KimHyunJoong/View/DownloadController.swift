import UIKit

class DownloadController: UIViewController {
    
    let downloadImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "download"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let messageLabelView1: UILabel = {
        let label = UILabel()
        label.text = "Movies and TV shows that you."
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messageLabelView2: UILabel = {
        let label = UILabel()
        label.text = "download appear here."
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Something to Download", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(downloadImageView)
        view.addSubview(messageLabelView1)
        view.addSubview(messageLabelView2)
        view.addSubview(downloadButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            downloadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            downloadImageView.widthAnchor.constraint(equalToConstant: 200),
            downloadImageView.heightAnchor.constraint(equalToConstant: 200),
            
            messageLabelView1.topAnchor.constraint(equalTo: downloadImageView.bottomAnchor, constant: 20),
            messageLabelView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabelView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageLabelView2.topAnchor.constraint(equalTo: messageLabelView1.bottomAnchor, constant: 5),
            messageLabelView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabelView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            downloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
            downloadButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
