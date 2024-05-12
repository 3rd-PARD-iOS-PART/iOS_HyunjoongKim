import UIKit

class AddPardViewController: UIViewController {
    let nameTextField = UITextField()
    let partTextField = UITextField()
    let ageTextField = UITextField()
    let saveButton = UIButton(type: .system)
    
    let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "데이터 추가"
        
        setupTextFields()
        setupSaveButton()
        setupConstraints()
    }
    
    func setupTextFields() {
        nameTextField.placeholder = "이름을 입력해주세요"
        nameTextField.borderStyle = .roundedRect
        
        partTextField.placeholder = "파트를 입력해주세요"
        partTextField.borderStyle = .roundedRect
        
        ageTextField.placeholder = "나이를 입력해주세요"
        ageTextField.borderStyle = .roundedRect
        ageTextField.keyboardType = .numberPad
    }
    
    func setupSaveButton() {
        saveButton.setTitle("추가하기", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, ageTextField, partTextField, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func saveButtonTapped() {
        guard let name = nameTextField.text,
              let part = partTextField.text,
              let ageString = ageTextField.text,
              let age = Int(ageString) else {
            return
        }

        let pard = Pard(id: 0, name: name, part: part, age: age)

        apiService.addPard(pard) { [weak self] error in
            if let error = error {
                print("Error adding pard: \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                // HomeViewController의 fetchPards() 메서드 호출
                if let homeVC = self?.navigationController?.viewControllers.first as? HomeViewController {
                    homeVC.fetchPards()
                }

                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
