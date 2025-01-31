//
//  UserWebService.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import Foundation

protocol UserWebServiceProtocol {
    func getUsers() async throws -> UserContainer
}

final class UserWebService: UserWebServiceProtocol {
    let urlString: String
    let session: URLSession
    
    init(urlString: String = Constants.userUrlString,
         session: URLSession = .shared) {
        self.session = session
        self.urlString = urlString
    }
    
    func getUsers() async throws -> UserContainer {
        
        guard let url = URL(string: urlString) else {
            throw SaError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw SaError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(UserContainer.self, from: data)
        } catch {
            throw SaError.invalidData
        }
    }
}
