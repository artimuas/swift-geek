//
//  APIManagerTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/15/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class APIManagerTests: XCTestCase {
	
	var seatGeekAPI: APIManager!
    
    override func setUp() {
        super.setUp()
	
		seatGeekAPI = APIManager()
    }
    
    override func tearDown() {
		seatGeekAPI = nil
		
        super.tearDown()
    }
	
	func testCanCreateSeatGeekAPIManager() {
		XCTAssertNotNil(seatGeekAPI, "Should be able to instantiate a SeatGeekAPIManager")
	}
	
	func testAPIManagerCanCreateURLToGivenEndpoint() {
		
	}
	
}
