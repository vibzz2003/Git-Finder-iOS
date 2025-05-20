

import UIKit

class FollowerCell: UITableViewCell {
    static let identifier = "FollowerCell"

    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)

        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),

            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            loginLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func Configure(with follower: UserModel) {
        loginLabel.text = follower.login
        LoadImage(from: follower.avatarUrl)
    }
    
    private func LoadImage(from urlString: String) {
        guard let url: URL = URL(string: urlString) else {
            avatarImageView.image = UIImage(systemName: "person.crop.circle")
            return
        }
        
        DispatchQueue.global().async {
            if let data: Data = try? Data(contentsOf: url),
               let image: UIImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(systemName: "person.crop.circle")
                }
            }
        }
    }
    
}
