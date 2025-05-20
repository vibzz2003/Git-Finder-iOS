

import Foundation

class UserModel: Codable {
    
    public var login: String
    public var id: Int
    public var nodeId: String
    public var avatarUrl: String
    public var gravatarId: String
    public var url: String
    public var htmlUrl: String
    public var followersUrl: String
    public var followingUrl: String
    public var gistsUrl: String
    public var starredUrl: String
    public var subscriptionsUrl: String
    public var organizationsUrl: String
    public var reposUrl: String
    public var eventsUrl: String
    public var receivedEventsUrl: String
    public var type: String
    public var siteAdmin: Bool
    public var name: String?
    public var company: String?
    public var blog: String?
    public var location: String?
    public var email: String?
    public var hireable: Bool?
    public var bio: String?
    public var twitterUsername: String?
    public var publicRepos: Int
    public var publicGists: Int
    public var followers: Int
    public var following: Int
    public var createdAt: Date
    public var updatedAt: Date
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decodeIfPresent(String.self, forKey: .login) ?? ""
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.nodeId = try container.decodeIfPresent(String.self, forKey: .nodeId) ?? ""
        self.avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl) ?? ""
        self.gravatarId = try container.decodeIfPresent(String.self, forKey: .gravatarId) ?? ""
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        self.htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl) ?? ""
        self.followersUrl = try container.decodeIfPresent(String.self, forKey: .followersUrl) ?? ""
        self.followingUrl = try container.decodeIfPresent(String.self, forKey: .followingUrl) ?? ""
        self.gistsUrl = try container.decodeIfPresent(String.self, forKey: .gistsUrl) ?? ""
        self.starredUrl = try container.decodeIfPresent(String.self, forKey: .starredUrl) ?? ""
        self.subscriptionsUrl = try container.decodeIfPresent(String.self, forKey: .subscriptionsUrl) ?? ""
        self.organizationsUrl = try container.decodeIfPresent(String.self, forKey: .organizationsUrl) ?? ""
        self.reposUrl = try container.decodeIfPresent(String.self, forKey: .reposUrl) ?? ""
        self.eventsUrl = try container.decodeIfPresent(String.self, forKey: .eventsUrl) ?? ""
        self.receivedEventsUrl = try container.decodeIfPresent(String.self, forKey: .receivedEventsUrl) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.siteAdmin = try container.decodeIfPresent(Bool.self, forKey: .siteAdmin) ?? false
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.company = try container.decodeIfPresent(String.self, forKey: .company) ?? ""
        self.blog = try container.decodeIfPresent(String.self, forKey: .blog) ?? ""
        self.location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.hireable = try container.decodeIfPresent(Bool.self, forKey: .hireable) ?? false
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        self.twitterUsername = try container.decodeIfPresent(String.self, forKey: .twitterUsername) ?? ""
        self.publicRepos = try container.decodeIfPresent(Int.self, forKey: .publicRepos) ?? 0
        self.publicGists = try container.decodeIfPresent(Int.self, forKey: .publicGists) ?? 0
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
        self.following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
        self.updatedAt = try container.decodeIfPresent(Date.self, forKey: .updatedAt) ?? Date()
    }
    
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url = "url"
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
        case name = "name"
        case company = "company"
        case blog = "blog"
        case location = "location"
        case email = "email"
        case hireable = "hireable"
        case bio = "bio"
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers = "followers"
        case following = "following"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

