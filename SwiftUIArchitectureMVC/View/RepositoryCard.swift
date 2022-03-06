//
//  RepositoryCard.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/06.
//

import SwiftUI

struct RepositoryCard: View {
    let repository: Repository
    
    var body: some View {
        VStack {
            HStack {
                Text(repository.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
            HStack {
                Text(repository.description ?? "")
                    .font(.caption)
                Spacer()
            }
            HStack {
                Text(repository.language ?? "")
                Spacer()
                Image(systemName: "star.fill")
                Text(String(repository.stargazersCount))
                Spacer()
                Text("falk: \(String(repository.forksCount))")
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

struct RepositoryCard_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCard(repository: Repository.mock)
    }
}
