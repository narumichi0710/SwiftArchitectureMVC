//
//  SearchMainModel.swift
//  SwiftUIArchitectureMVC
//
//  Created by Narumichi Kubo on 2022/03/04.
//

import Foundation

class SearchModel: ObservableObject {
    @Published var users = [User]()
    @Published var isNotFound = false

    @Published var repositories = [Repository]()
    @Published var isLoading = true

    @Published var error: ModelError?
    
    
    private var endPoint: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        return components
    }
    
    private func userSearchEndpoint(query: String) -> URL? {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            error = .encodingError
            return nil
        }
        
        var urlComponents = endPoint
        urlComponents.path = "/search/users"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: encodedQuery)]
        guard let url = urlComponents.url else {
            error = .urlError
            return nil
        }
        return url
    }
    
    public func fetchUser(query: String) {
        users = [User]()
        error = nil
        
        guard !query.isEmpty,
              let url = userSearchEndpoint(query: query)
        else { return }
        
        Task {
            let result = await fetch(url: url)
            
            switch result {
            case .success(let data):
                guard let users = try? JSONDecoder().decode(Users.self, from: data) else {
                    error = .jsonParseError(String(data: data, encoding: .utf8) ?? "")
                    return
                }
                publishUsers(users: users)
            case .failure(let error):
                self.error = .responseError(error)
            }
        }
    }
    
    @MainActor
    private func fetch(url: URL) async -> Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
    
    private func publishUsers(users: Users) {
        if users.totalCount == 0 {
            isNotFound = true
            self.users = [User]()
            return
        }
        self.users = users.items
    }

    
    public func fetchRepositories(urlString: String) {
        defer {
            isLoading = false
        }

        guard let url = URL(string: urlString) else {
            error = .urlError
            return
        }
        
        Task {
            let result = await fetch(url: url)
            
            switch result {
            case .success(let data):
                guard let repositories = try? JSONDecoder().decode([Repository].self, from: data) else {
                    error = .jsonParseError(String(data: data, encoding: .utf8) ?? "")
                    return
                }
                self.repositories = repositories
            case .failure(let error):
                self.error = .responseError(error)
            }
        }
    }
}

