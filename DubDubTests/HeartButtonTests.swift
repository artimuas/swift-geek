//
//  HeartButtonTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class HeartButtonTests: XCTestCase {
	
	var heartButton: HeartButton!
    
    override func setUp() {
        super.setUp()
		
		heartButton = HeartButton(type: UIButtonType.custom)
		heartButton.setNeedsLayout()
    }
    
    override func tearDown() {
		heartButton = nil
		
        super.tearDown()
    }
	
	func testCanCreateHeartButton() {
		XCTAssertNotNil(heartButton, "Should be able to instantiate a heartButton")
	}
	
}
