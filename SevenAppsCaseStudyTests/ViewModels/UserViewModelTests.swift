//
//  UserViewModelTests.swift
//  SevenAppsCaseStudyTests
//
//  Created by Turker Alan on 30.01.2025.
//

import XCTest

@testable import SevenAppsCaseStudy

final class UsersViewModelTests: XCTestCase {
    
    var viewModel: UsersViewModel!
    var mockWebService: MockUserWebService!
    var mockDelegate: MockUserDelegate!
    
    override func setUp() {
        super.setUp()
        // Initialize mock dependencies before each test
        mockWebService = MockUserWebService()
        mockDelegate = MockUserDelegate()
        viewModel = UsersViewModel(delegate: mockDelegate, webService: mockWebService)
    }
    
    override func tearDown() {
        // Clean up resources to avoid test interference
        viewModel = nil
        mockWebService = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testUserViewModel_WhenGivenCorrectUser_ReturnSuccess() async {
        // Arrenge
        // Create a mock user with valid data
        let address = Address(street: "bla", suite: "bla", city: "bla", zipcode: "bla")
        let company = Company(name: "bla", catchPhrase: "bla", bs: "bla")
        mockWebService.mockUsers = [User(id: 0,
                                         name: "John",
                                         username: "john",
                                         email: "test@test.com",
                                         address: address,
                                         phone: "123456789",
                                         website: "bla.com",
                                         company: company)]

        // Act
        viewModel.getUsers()
        try? await Task.sleep(nanoseconds: 100_000_000) // Wait for async task
        
        // Assert
        // Ensure the delegate received a success output
        XCTAssertTrue(mockDelegate.receivedOutputs.contains(where: { output in
            output == .success
        }), "Expected Success output but got another output")
        XCTAssertEqual(viewModel.users.count, 1, "Expected users count to be 1, but got \(viewModel.users.count)")
    }
    
    func testUserViewModel_WhenGivenError_ReturnError() async {
        // Arrenge
        // Simulate a scenario where the web service returns an error
        mockWebService.shouldReturnError = true
        
        // Act
        viewModel.getUsers()
        try? await Task.sleep(nanoseconds: 100_000_000) // Wait for async task
        
        // Assert
        // Ensure the delegate received a failure output with the expected error message
        XCTAssertTrue(mockDelegate.receivedOutputs.contains { output in
            if case .fail(let errorMessage) = output {
                return errorMessage == SaError.invalidResponse.description
            }
            return false
        }, "Expected output is Fail with error message \(SaError.invalidResponse.description) but do not got it.")
    }
}
