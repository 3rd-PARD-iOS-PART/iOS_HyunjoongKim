import UIKit

extension UIImage {
    // 이미지 크기를 유지하면서 비율에 맞게 조정하는 메서드
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
        // 각 탭에 해당하는 뷰 컨트롤러 생성
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = SearchViewController()
        let vc3 = UINavigationController(rootViewController: ComingController())
        let vc4 = UINavigationController(rootViewController: DownloadController())
        let vc5 = UINavigationController(rootViewController: MoreController())
        
        let searchNavigationController = UINavigationController(rootViewController: vc2)
        
        self.viewControllers = [vc1, searchNavigationController, vc3, vc4, vc5]
        
        // 탭 바의 선택된 아이템 색상을 흰색으로 설정
        self.tabBar.tintColor = .white
        // 탭 바의 배경색을 검정색으로 설정
        self.tabBar.backgroundColor = .black
        // 탭 바의 바 색상을 검정색으로 설정
        self.tabBar.barTintColor = .black
        // 탭 바의 선택되지 않은 아이템 색상을 회색으로 설정
        self.tabBar.unselectedItemTintColor = .gray
        
        // 탭 바 아이템 가져오기
        guard let tabBarItems = self.tabBar.items else { return }
        
        // 탭 바 아이템 이미지 크기 설정
        let imageSize = CGSize(width: 24, height: 24)
        // 각 탭 바 아이템에 이미지와 제목 설정
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
        
        // 탭 바 아이템 제목 폰트 크기 설정
        let fontSize: CGFloat = 12
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        // 각 탭 바 아이템의 제목 텍스트 속성 설정
        for tabBarItem in tabBarItems {
            tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        }
    }
}
