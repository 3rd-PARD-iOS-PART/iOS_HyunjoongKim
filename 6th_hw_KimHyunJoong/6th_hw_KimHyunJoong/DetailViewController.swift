import UIKit

class DetailViewController: UIViewController {
    
    let nameLabel = UILabel()
    let partLabel = UILabel()
    let ageLabel = UILabel()
    
    var pard: Pard?
    let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        updateUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        // 레이블 설정
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        partLabel.font = UIFont.systemFont(ofSize: 16)
        ageLabel.font = UIFont.systemFont(ofSize: 16)
        
        // 레이블 스택뷰 생성 및 설정
        let labelStackView = UIStackView(arrangedSubviews: [nameLabel, partLabel, ageLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        labelStackView.alignment = .center
        
        // 레이블 스택뷰를 뷰에 추가하고 제약 추가
        view.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupNavigationBar() {
        let deleteButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonTapped))
        deleteButtonItem.tintColor = .red
        navigationItem.leftBarButtonItem = deleteButtonItem
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    func updateUI() {
        nameLabel.text = pard?.name
        partLabel.text = "파트: \(pard?.part ?? "")"
        ageLabel.text = "나이: \(pard?.age ?? 0)"
    }
    
    @objc func deleteButtonTapped() {
        let alertController = UIAlertController(title: "정말로 삭제하시겠습니까?", message: "삭제한 내용은 다시 되돌릴 수 없습니다.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            guard let pard = self?.pard else { return }
            
            self?.apiService.deletePard(id: pard.id) { error in
                if let error = error {
                    print("Error deleting pard: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    if let homeVC = self?.navigationController?.viewControllers.first as? HomeViewController {
                        homeVC.fetchPards()
                    }
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func editButtonTapped() {
        let alertController = UIAlertController(title: "파드 정보 수정", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "이름"
            textField.text = self.pard?.name
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "파트"
            textField.text = self.pard?.part
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "나이"
            textField.text = "\(self.pard?.age ?? 0)"
            textField.keyboardType = .numberPad
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            let nameTextField = alertController.textFields?[0]
            let partTextField = alertController.textFields?[1]
            let ageTextField = alertController.textFields?[2]
            
            let updatedName = nameTextField?.text ?? ""
            let updatedPart = partTextField?.text ?? ""
            let updatedAge = Int(ageTextField?.text ?? "") ?? 0
            
            let updatedPard = Pard(id: self.pard?.id ?? 0, name: updatedName, part: updatedPart, age: updatedAge)
            
            self.apiService.editPard(pard: updatedPard) { error in
                if let error = error {
                    print("Error updating pard: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
//                    let homeVC = HomeViewController()
//                    homeVC.fetchPards()
//
                    if let homeVC = self.navigationController?.viewControllers.first as? HomeViewController {
                        homeVC.fetchPards()
                    }
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
