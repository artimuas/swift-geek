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
       
}
