//
//  MockUserWebService.swift
//  SevenAppsCaseStudyTests
//
//  Created by Turker Alan on 30.01.2025.
//

import Foundation
@testable import SevenAppsCaseStudy

class MockUserWebService: UserWebServiceProtocol {
    var shouldReturnError = false
    var mockUsers: UserContainer = []
    
    func getUsers() async throws -> UserContainer {
        if shouldReturnError {
            throw SaError.invalidResponse
        }
        return mockUsers
    }
}
