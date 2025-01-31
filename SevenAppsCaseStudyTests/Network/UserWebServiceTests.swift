//
//  UserWebServiceTests.swift
//  SevenAppsCaseStudyTests
//
//  Created by Turker Alan on 30.01.2025.
//

import XCTest
@testable import SevenAppsCaseStudy

final class UserWebServiceTests: XCTestCase {
    
    var sut: UserWebService! // System Under Test (SUT)
    var mockSession: URLSession! // Mocked URLSession to intercept network calls
    
    override func setUp() {
        super.setUp()
        // Configure a mock session using a custom URLProtocol to intercept network requests
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        
        // Initialize the SUT with the mock session to ensure controlled test conditions
        sut = UserWebService(session: mockSession)
    }
    
    override func tearDown() {
        // Clean up resources to avoid test interference
        sut = nil
        mockSession = nil
        MockURLProtocol.responseData = nil
        MockURLProtocol.responseError = nil
        MockURLProtocol.responseStatusCode = 200 // Reset status code to default
        super.tearDown()
    }
    
    func testUserWebService_WhenGivenSuccessfullResponse_ReturnSuccess() async throws {
        // Arrange
        // Mock a successful JSON response simulating API response
        if let mockJSON = "[\n{\n\"id\": 1,\n\"name\": \"Leanne Graham\",\n\"username\": \"Bret\",\n\"email\": \"Sincere@april.biz\",\n\"address\": {\n\"street\": \"Kulas Light\",\n\"suite\": \"Apt. 556\",\n\"city\": \"Gwenborough\",\n\"zipcode\": \"92998-3874\",\n\"geo\": {\n\"lat\": \"-37.3159\",\n\"lng\": \"81.1496\"\n}\n},\n\"phone\": \"1-770-736-8031 x56442\",\n\"website\": \"hildegard.org\",\n\"company\": {\n\"name\": \"Romaguera-Crona\",\n\"catchPhrase\": \"Multi-layered client-server neural-net\",\n\"bs\": \"harness real-time e-markets\"\n}\n}]".data(using: .utf8) {
            MockURLProtocol.responseData = mockJSON
        }
        
        // Act
        let result = try await sut.getUsers()
        
        // Assert
        // Validate expected values against the received response
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "Leanne Graham")
    }
    
    func testUserWebService_WhenInvalidResponseGiven_ReturnError() async {
        // Arrange
        // Simulate an invalid server response
        MockURLProtocol.responseStatusCode = 404
        
        // Act
        do {
            _ = try await sut.getUsers()
            XCTFail("Expected an error but got success") // Fail the test if no error is thrown
        } catch {
            // Assert
            // Ensure the error thrown is the expected one
            XCTAssertEqual(error as? SaError, SaError.invalidResponse, "Expected invalidResponse but got another error.")
        }
    }
    
    func testUserWebService_WhenInvalidDataGiven_ReturnError() async {
        // Arrange
        // Simulate invalid JSON response
        MockURLProtocol.responseData = "invalid json".data(using: .utf8)
        
        // Act
        do {
            _ = try await sut.getUsers()
            XCTFail("Expected an error but got success") // Fail the test if no error is thrown
        } catch {
            // Assert
            // Ensure the error thrown is the expected one
            XCTAssertEqual(error as? SaError, SaError.invalidData, "Expected invalidData but got another error.")
        }
    }
    
    func testUserWebService_WhenEmptyURLProvided_ReturnError() async {
        // Arrange
        // Simulate a scenario where an invalid empty URL is passed to the service
        sut = UserWebService(urlString: "")
        
        // Act
        do {
            _ = try await sut.getUsers()
            XCTFail("Expected an error but got success") // Fail the test if no error is thrown
        } catch {
            // Assert
            // Ensure the error thrown is the expected one
            XCTAssertEqual(error as? SaError, SaError.invalidURL, "Expected invalidURL but got another error.")
        }
        
        
    }
}
