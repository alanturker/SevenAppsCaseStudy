//
//  UserViewModel.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import Foundation

protocol UserViewModelProtocol: AnyObject {
    var users: UserContainer { get set }
    var delegate: UserDelegate? { get set }
    func getUsers()
}

protocol UserDelegate: AnyObject {
    func notify(_ output: UserViewModelOutput)
}

enum UserViewModelOutput: Equatable {
    case success
    case fail(String)
    case loading(_ isLoading: Bool)
}

final class UsersViewModel: UserViewModelProtocol {
    var users: UserContainer = []
    var webService: UserWebServiceProtocol
    
    weak var delegate: UserDelegate?
    
    init(delegate: UserDelegate, webService: UserWebServiceProtocol = UserWebService()) {
        self.delegate = delegate
        self.webService = webService
    }
    
    func getUsers() {
        delegate?.notify(.loading(true))
        
        Task {
            do {
                users = try await webService.getUsers()
                delegate?.notify(.success)
                delegate?.notify(.loading(false))
            } catch {
                if let saError = error as? SaError {
                    delegate?.notify(.fail(saError.description))
                    delegate?.notify(.loading(false))
                } else {
                    delegate?.notify(.fail(error.localizedDescription))
                    delegate?.notify(.loading(false))
                }
            }
        }
    }
}
