
    
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GitHub User Finder"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.shadowColor = UIColor.black.withAlphaComponent(0.1)
        label.shadowOffset = CGSize(width: 0, height: 2)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter GitHub username"
        textField.borderStyle = .none
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.cornerRadius = 10
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.SetLeftPaddingPoints(12)
        textField.SetRightPaddingPoints(12)
        textField.font = .systemFont(ofSize: 16)
        textField.delegate = self
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var moreLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "More Options"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        
        AddFeatureRow(title: "Find Followers", buttonTitle: "View", action: #selector(FindFollowersTapped))
        AddFeatureRow(title: "Find Repositories", buttonTitle: "View", action: #selector(FindReposTapped))
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(moreLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            textField.heightAnchor.constraint(equalToConstant: 44),
            
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 120),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            
            moreLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 50),
            moreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: moreLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        searchButton.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func ButtonTapped() {
        guard let userName: String = textField.text else { return }
        
        let urlString: String = "https://api.github.com/users/\(userName)"
        NetworkManager.shared.GetRequest(urlString: urlString, responseModel: UserModel.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    let detailVC = UserDetailViewController()
                    detailVC.Configure(user: user)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                case .failure(let error):
                    print("Error fetching user:", error)
                }
            }
        }
    }
    
    private func AddFeatureRow(title: String, buttonTitle: String, action: Selector) {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16)

        let button = UIButton(type: .system)
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)

        let horizontalStack = UIStackView(arrangedSubviews: [label, button])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        horizontalStack.distribution = .equalSpacing

        stackView.addArrangedSubview(horizontalStack)
    }
    
    @objc private func FindFollowersTapped() {
        print("Followers button tapped")
        let vc = FollowersViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func FindReposTapped() {
        print("Repos button tapped")
        //TO DO
    }
}

extension UITextField {
    func SetLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func SetRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
