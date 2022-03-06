//
//  UserController.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/06.
//

import Foundation

struct UserController {
    let model: SearchModel
    let query: String
    
    public func loadStart() {
        model.fetchUser(query: query)
    }
}
