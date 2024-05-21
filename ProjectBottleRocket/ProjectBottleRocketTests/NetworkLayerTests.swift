//
//  NetworkLayerTests.swift
//  ProjectBottleRocketTests
//
//  Created by Ke Liu on 5/21/24.
//

import XCTest
@testable import ProjectBottleRocket

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var mockSession: MockSession!
    
    override func setUp() {
        super.setUp()
        mockSession = MockSession()
        networkManager = NetworkManager(session: mockSession)
    }
    
    override func tearDown() {
        networkManager = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testFetchDecodableDataReturnsValidResponse() {
        // Given
        let expectedData = """
        {
            "id": 1,
            "name": "Test"
        }
        """.data(using: .utf8)!
        
        mockSession.data = expectedData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let url = URL(string: "https://apple.com")
        
        let expectation = self.expectation(description: "Completion handler called")
        
        // When
        networkManager.fetchDecodableData(url: url) { (result: Result<MockDecodable, Error>) in
            switch result {
            case .success(let decodedObject):
                XCTAssertEqual(decodedObject.id, 1)
                XCTAssertEqual(decodedObject.name, "Test")
            case .failure(let error):
                XCTFail("Expected success, got \(error) instead")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchDecodableDataHandlesInvalidURL() {
        // Given
        let url: URL? = nil
        
        let expectation = self.expectation(description: "Completion handler called")
        
        // When
        networkManager.fetchDecodableData(url: url) { (result: Result<MockDecodable, Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                XCTAssertEqual(error as? ErrorMessage, ErrorMessage.badURL)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchRawDataReturnsValidResponse() {
        // Given
        let expectedData = Data([0, 1, 0, 1])
        
        mockSession.data = expectedData
        mockSession.response = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let url = URL(string: "https://apple.com")
        
        let expectation = self.expectation(description: "Completion handler called")
        
        // When
        networkManager.fetchRawData(url: url) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, expectedData)
            case .failure(let error):
                XCTFail("Expected success, got \(error) instead")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchRawDataHandlesInvalidURL() {
        // Given
        let url: URL? = nil
        
        let expectation = self.expectation(description: "Completion handler called")
        
        // When
        networkManager.fetchRawData(url: url) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, got success instead")
            case .failure(let error):
                XCTAssertEqual(error as? ErrorMessage, ErrorMessage.badURL)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testPerformErrorCheckingHandlesError() {
        // Given
        let error = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        // When
        let result = networkManager.performErrorChecking(nil, nil, error)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure, got success instead")
        case .failure(let receivedError as NSError):
            XCTAssertEqual(receivedError, error)
        }
    }
    
    func testPerformErrorCheckingHandlesInvalidStatusCode() {
        // Given
        let response = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        // When
        let result = networkManager.performErrorChecking(nil, response, nil)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure, got success instead")
        case .failure(let error as ErrorMessage):
            switch error {
            case .badStatusCode(let statusCode):
                XCTAssertEqual(statusCode, 404)
            default:
                XCTFail("Expected badStatusCode error, got \(error) instead")
            }
        case .failure:
            XCTFail("Expected ErrorMessage, got another error instead")
        }
    }
    
    func testPerformErrorCheckingReturnsValidData() {
        // Given
        let data = Data([0, 1, 0, 1])
        let response = HTTPURLResponse(url: URL(string: "https://apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        // When
        let result = networkManager.performErrorChecking(data, response, nil)
        
        // Then
        switch result {
        case .success(let receivedData):
            XCTAssertEqual(receivedData, data)
        case .failure(let error):
            XCTFail("Expected success, got \(error) instead")
        }
    }
    
    func testErrorMessageDescriptionsAreCorrect() {
        XCTAssertEqual(ErrorMessage.badURL.localizedDescription, "Bad URL")
        XCTAssertEqual(ErrorMessage.badData.localizedDescription, "Bad Data")
        XCTAssertEqual(ErrorMessage.decodingFailed.localizedDescription, "Decoding Failed")
        XCTAssertEqual(ErrorMessage.badStatusCode(404).localizedDescription, "The network connection was improper. Received Status code 404")
    }
}

// Define a mock decodable struct for testing purposes
struct MockDecodable: Decodable {
    let id: Int
    let name: String
}
