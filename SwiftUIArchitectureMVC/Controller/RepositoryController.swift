//
//  RepositoryController.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/06.
//

import Foundation

struct RepositoryController {
    let model: SearchModel
    let urlString: String

    public func loadStart() {
        model.fetchRepositories(urlString: urlString)
    }

}
