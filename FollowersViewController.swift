
    
import Foundation
import UIKit

class FollowersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowerCell.identifier, for: indexPath) as? FollowerCell else {
            return UITableViewCell()
        }
        let follower = followers[indexPath.row]
        cell.Configure(with: follower)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let follower = followers[indexPath.row]
        if let url = URL(string: follower.htmlUrl) {
            UIApplication.shared.open(url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    private var followers: [UserModel] = []
    private var currentUsername: String?
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter GitHub username"
        sb.autocapitalizationType = .none
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.register(FollowerCell.self, forCellReuseIdentifier: FollowerCell.identifier)
        tv.rowHeight = UITableView.automaticDimension
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Followers"
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        SetupConstraints()
    }
    
    private func SetupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func FetchFollowers(userName: String) {
        let urlString = "https://api.github.com/users/\(userName)/followers?per_page=100&page=1"
        NetworkManager.shared.GetRequest(urlString: urlString, responseModel: [UserModel].self) { [ weak self ] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let followers):
                    self?.followers = followers
                    self?.currentUsername = userName
                    self?.title = "\(userName)'s Followers"
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.followers = []
                    self?.tableView.reloadData()
                    self?.ShowError(error: error)
                }
            }
        }
    }
    
    private func ShowError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Failed to fetch followers.\n\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let username = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !username.isEmpty else {
            return
        }
        searchBar.resignFirstResponder()
        FetchFollowers(userName: username)
    }
}
