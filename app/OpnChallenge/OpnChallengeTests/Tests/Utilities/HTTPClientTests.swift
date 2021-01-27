//
//  HTTPClientTests.swift
//  OpnChallengeTests
//
//  Created by Abid Rahman on 27/1/21.
//

import XCTest
@testable import OpnChallenge

struct TestModel: Codable {
    let name: String
    let age: Int
}

struct IncorrectTestModel: Codable {
    let namee: String
    let age: Int
}

class HTTPClientTests: XCTestCase {
    var sut: HTTPClient!
    var mockURLSession: MockURLSession!

    private let dummyURL = URL(string: "www.google.com")!

    override func setUp() {
        super.setUp()

        self.mockURLSession = MockURLSession()
        self.sut = HTTPClient(urlSession: self.mockURLSession)
    }

    // MARK: - Tests for GET request

    func testGetRequestWhenSuccess() {
        let expectedResponseObject = TestModel(name: "name", age: 30)

        let responseData = try? JSONEncoder().encode(expectedResponseObject)
        let httpResponse = HTTPURLResponse(url: self.dummyURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        self.mockURLSession.completionHandlerData = (responseData, httpResponse, nil)

        self.sut.getRequest(requestURL: self.dummyURL, responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.responseObject?.age, expectedResponseObject.age)
                XCTAssertEqual(response.responseObject?.name, expectedResponseObject.name)
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testGetRequestWhenInternetFailure() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        self.mockURLSession.completionHandlerData = (nil, nil, error)

        let expectedHTTPClientError = HTTPClientError(errorType: .noInternetConnection, description: nil)

        self.sut.getRequest(requestURL: self.dummyURL, responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    func testGetRequestWhenJSONParsingFailure() {
        let incorrectResponseObject = IncorrectTestModel(namee: "name", age: 30)

        let responseData = try? JSONEncoder().encode(incorrectResponseObject)
        let httpResponse = HTTPURLResponse(url: self.dummyURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        self.mockURLSession.completionHandlerData = (responseData, httpResponse, nil)

        let expectedHTTPClientError = HTTPClientError(errorType: .parsingJSON, description: nil)

        self.sut.getRequest(requestURL: self.dummyURL, responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    func testGetRequestWhenErrorResponseFailure() {
        let expectedResponseObject = IncorrectTestModel(namee: "name", age: 30)

        let responseData = try? JSONEncoder().encode(expectedResponseObject)
        let httpResponse = HTTPURLResponse(url: self.dummyURL,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)
        self.mockURLSession.completionHandlerData = (responseData, httpResponse, nil)

        let expectedHTTPClientError = HTTPClientError(errorType: .errorResponse(500), description: nil)

        self.sut.getRequest(requestURL: self.dummyURL, responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    func testGetRequestWhenHttpResponseIsNil() {
        let expectedResponseObject = IncorrectTestModel(namee: "name", age: 30)

        let responseData = try? JSONEncoder().encode(expectedResponseObject)
        self.mockURLSession.completionHandlerData = (responseData, nil, nil)

        let expectedHTTPClientError = HTTPClientError(errorType: .unknown, description: nil)

        self.sut.getRequest(requestURL: self.dummyURL, responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    // MARK: - Tests for POST request

    func testPostRequestWhenSuccess() {
        let expectedResponseObject = TestModel(name: "name", age: 30)

        let responseData = try? JSONEncoder().encode(expectedResponseObject)
        let httpResponse = HTTPURLResponse(url: self.dummyURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        self.mockURLSession.completionHandlerData = (responseData, httpResponse, nil)

        self.sut.postRequest(requestURL: self.dummyURL, requestBodyData: Data(), responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.responseObject?.age, expectedResponseObject.age)
                XCTAssertEqual(response.responseObject?.name, expectedResponseObject.name)
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testPostRequestWhenInternetFailure() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        self.mockURLSession.completionHandlerData = (nil, nil, error)

        let expectedHTTPClientError = HTTPClientError(errorType: .noInternetConnection, description: nil)

        self.sut.postRequest(requestURL: self.dummyURL, requestBodyData: Data(), responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    func testPostRequestWhenJSONParsingFailure() {
        let incorrectResponseObject = IncorrectTestModel(namee: "name", age: 30)

        let responseData = try? JSONEncoder().encode(incorrectResponseObject)
        let httpResponse = HTTPURLResponse(url: self.dummyURL,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
        self.mockURLSession.completionHandlerData = (responseData, httpResponse, nil)

        let expectedHTTPClientError = HTTPClientError(errorType: .parsingJSON, description: nil)

        self.sut.postRequest(requestURL: self.dummyURL, requestBodyData: Data(), responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    func testPostRequestWhenErrorResponseFailure() {
        let expectedResponseObject = IncorrectTestModel(namee: "name", age: 30)

        let responseData = try? JSONEncoder().encode(expectedResponseObject)
        let httpResponse = HTTPURLResponse(url: self.dummyURL,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)
        self.mockURLSession.completionHandlerData = (responseData, httpResponse, nil)

        let expectedHTTPClientError = HTTPClientError(errorType: .errorResponse(500), description: nil)

        self.sut.postRequest(requestURL: self.dummyURL, requestBodyData: Data(), responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }

    func testPostRequestWhenHttpResponseIsNil() {
        let expectedResponseObject = IncorrectTestModel(namee: "name", age: 30)

        let responseData = try? JSONEncoder().encode(expectedResponseObject)
        self.mockURLSession.completionHandlerData = (responseData, nil, nil)

        let expectedHTTPClientError = HTTPClientError(errorType: .unknown, description: nil)

        self.sut.postRequest(requestURL: self.dummyURL, requestBodyData: Data(), responseModelType: TestModel.self) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error.errorType, expectedHTTPClientError.errorType)
                XCTAssertEqual(error.errorMessage, expectedHTTPClientError.errorMessage)
            }
        }
    }
}
