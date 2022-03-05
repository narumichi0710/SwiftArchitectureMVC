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
        case totalCount = "totalCount"
        case incompleteResults = "incompleteResults"
        case items
    }
}

struct User: Codable, Identifiable {
    let id: String = UUID().uuidString
    let login: String
    let avatarUrl: String
    let reposUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatarUrl"
        case reposUrl = "repos_url"
    }
}
