//
//  Repository.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/06.
//

import Foundation

struct Repository: Codable, Identifiable {
    let id = UUID()
    let name: String
    let htmlUrl: String
    let description: String?
    let language: String?
    let stargazersCount: Int
    let forksCount: Int

    private enum CodingKeys: String, CodingKey {
        case name
        case htmlUrl = "html_url"
        case description
        case language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
    
    static let mock = Repository(name: "SwiftUIArchitectureMVC",
                                 htmlUrl: "https://github.com/narumichi0710/SwiftUIArchitectureMVC",
                                 description: "SwiftUIArchitectureMVC",
                                 language: "Swift",
                                 stargazersCount: 1000,
                                 forksCount: 100)
}
