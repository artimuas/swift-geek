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
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {		
        super.tearDown()
    }
		
	func testAPIManagerCanCreateURLToGivenEndpoint() {
        let testURL = URL(string: "https://api.seatgeek.com/2/events?client_id=Nzc3NDQwMnwxNDk2ODcwMjI0LjUx&type=mlb&page=0")
        let eventsURL = APIManager.eventsURL 
		XCTAssertEqual(testURL, eventsURL, "APIManager should create the appropriate URL for events endpoint")
	}
	
}
