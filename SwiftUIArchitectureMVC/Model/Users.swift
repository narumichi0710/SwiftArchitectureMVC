//
//  User.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/05.
//

import Foundation

struct Users: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [User]

    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
struct User: Codable, Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let reposUrl: String
    static let mockUser = User(login: "narumichi0710",
                               avatarUrl: "https://avatars.githubusercontent.com/u/65114797?v=4",
                               reposUrl: "https://api.github.com/users/narumichi0710/repos")

    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
}


