//
//  ContentView.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/04.
//

import SwiftUI

struct SearchMainView: View {
    @State private var searchText: String = ""
    @ObservedObject var model = SearchModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search User Name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .padding()
                Spacer()
                if let error = model.error {
                    Text(error.localizedDescription)
                } else {
                    List(model.users) { user in
                        NavigationLink(
                            destination:RepositoryView(repositoryUrlString:user.reposUrl)
                        ) {
                            UserCard(user: user)
                        }
                    }
                    .refreshable {
                        UserController(model: model, query: searchText).loadStart()
                    }
                }
            }
            .navigationTitle("🔍Search Github User")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
}
