//
//  UserCard.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/06.
//

import SwiftUI

struct UserCard: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            .frame(width: 50, height: 50)
            .padding()
            Spacer()
            Text(user.login)
                .padding()
            Spacer()
        }
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        UserCard(user: User.mockUser)
    }
}
