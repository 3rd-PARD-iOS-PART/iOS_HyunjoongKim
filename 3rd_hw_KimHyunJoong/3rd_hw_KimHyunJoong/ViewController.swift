import UIKit

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledImageSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        
        return scaledImage
    }
}


class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // NavigationBar 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    func setTabBar() {
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: ComingController())
        let vc4 = UINavigationController(rootViewController: DownloadController())
        let vc5 = UINavigationController(rootViewController: MoreController())
        
        self.viewControllers = [vc1, vc2, vc3, vc4, vc5]
        
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = .black
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
        
        
        guard let tabBarItems = self.tabBar.items else { return }
        
        let imageSize = CGSize(width: 24, height: 24)
        tabBarItems[0].image = UIImage(named: "tab_home")?.scalePreservingAspectRatio(targetSize: imageSize)
        tabBarItems[1].image = UIImage(named: "tab_search")?.scalePreservingAspectRatio(targetSize: imageSize)
        tabBarItems[2].image = UIImage(named: "tab_playlist")?.scalePreservingAspectRatio(targetSize: imageSize)
        tabBarItems[3].image = UIImage(named: "tab_down")?.scalePreservingAspectRatio(targetSize: imageSize)
        tabBarItems[4].image = UIImage(named: "tab_menu")?.scalePreservingAspectRatio(targetSize: imageSize)
        
        tabBarItems[0].title = "Home"
        tabBarItems[1].title = "Search"
        tabBarItems[2].title = "Coming Soon"
        tabBarItems[3].title = "Downloads"
        tabBarItems[4].title = "More"
        
        let fontSize: CGFloat = 12
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        for tabBarItem in tabBarItems {
            tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        }
    }
}
