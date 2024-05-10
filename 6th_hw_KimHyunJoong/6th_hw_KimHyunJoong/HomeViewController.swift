import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var pards: [Pard] = []
    let apiService = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UrlSession"
        view.backgroundColor = .white
        
        setupTableView()
        setupNavigationBar()
        fetchPards()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func fetchPards() {
        apiService.getPards { [weak self] pards, error in
            if let error = error {
                print("Error fetching pards: \(error.localizedDescription)")
                return
            }
            self?.pards = pards ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pard = pards[indexPath.row]
        cell.textLabel?.text = "[\(pard.part)] \(pard.name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPard = pards[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.pard = selectedPard
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func addButtonTapped() {
        let addPardViewController = AddPardViewController()
        navigationController?.pushViewController(addPardViewController, animated: true)
    }
}
