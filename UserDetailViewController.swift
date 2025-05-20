
    
import UIKit

class UserDetailViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        SetupUI()
    }
    
    func Configure(user: UserModel) {
        self.user = user
    }
    
    func SetupUI() {
        guard let user = user else { return }
        
        if let url = URL(string: user.avatarUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let infoLabels = [
            "Login: \(user.login)",
            "ID: \(user.id)",
            "Name: \(user.name ?? "N/A")",
            "Company: \(user.company ?? "N/A")",
            "Location: \(user.location ?? "N/A")",
            "Email: \(user.email ?? "N/A")",
            "Followers: \(user.followers)",
            "Following: \(user.following)"
        ]
        
        for text in infoLabels {
            let label: UILabel = UILabel()
            label.text = text
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 14)
            stackView.addArrangedSubview(label)
        }
    }
}
