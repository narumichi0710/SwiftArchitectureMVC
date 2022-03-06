//
//  RepositoryView.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/05.
//

import SwiftUI

struct RepositoryView: View {
    let repositoryUrlString: String
    @ObservedObject var model = SearchModel()
    
    var body: some View {
        if let error = model.error {
            Text(error.localizedDescription)
        } else {
            if model.isLoading {
                ProgressView()
                    .scaleEffect(x: 3, y: 3, anchor: .center)
                    .onAppear {
                        RepositoryController(model: model, urlString: repositoryUrlString).loadStart()
                    }
            } else {
                if model.repositories.isEmpty {
                    Text("No Repository")
                } else {
                    List(model.repositories) { repository in
                        RepositoryCard(repository: repository)
                    }
                }
            }
        }
    }
}


struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(repositoryUrlString: "https://api.github.com/users/narumichi0710/repos")
    }
}
