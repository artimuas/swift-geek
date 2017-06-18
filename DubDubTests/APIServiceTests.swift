//
//  APIServiceTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/15/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class APIServiceTests: XCTestCase {
    
    var service: APIService!
    
    override func setUp() {
        super.setUp()
        
        service = APIService()
    }
    
    override func tearDown() {
        service = nil
        
        super.tearDown()
    }
    
    func testCanCreateAService() {
        XCTAssertNotNil(service, "Should be able to create a new APIService")
    }
	
	func testServiceShouldSetQueryStringToAPIManagerQuery() {
		let exp = expectation(description: "Service sends the getEvents request")
		
		
		service.getEventsFor(query: "abc", onPage: 1, completion: { (result) in
			XCTAssertEqual(APIManager.query, "abc", "Service should set the query string on APIManager's query property")
			
			exp.fulfill()
		})
		
		waitForExpectations(timeout: 10) { (error) in
			XCTFail("Expectation wait failed with error")
		}
		
	}
	
	func testServiceShouldSetPageToAPIManagerPage() {
		let exp = expectation(description: "Service sends the getEvents request")
		
		
		service.getEventsFor(query: "abc", onPage: 1, completion: { (result) in
			XCTAssertEqual(APIManager.page, 1, "Service should set the page on APIManager's page property")
			
			exp.fulfill()
		})
		
		waitForExpectations(timeout: 10) { (error) in
			XCTFail("Expectation wait failed with error")
		}
	}

	func testServiceReturnsErrorIfNoQueryPresent() {
		service.getEventsFor(query: nil, onPage: 1) { (result) in
			if case .failure(let error) = result , case .invalidQuery(let invalid) = error {
				XCTAssertEqual(invalid, "Invalid Query", "Service should send an error if query is nil")
			}
		}
	}

	func testServiceReturnsSuccessIfDataTaskSucceeds() {
		
	}
	
}
