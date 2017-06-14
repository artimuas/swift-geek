//
//  HeartImageViewTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class HeartImageViewTests: XCTestCase {
	
	var heartImageView: HeartImageView!
    
    override func setUp() {
        super.setUp()
		
		heartImageView = HeartImageView()
		heartImageView.setNeedsLayout()
    }
    
    override func tearDown() {
		heartImageView = nil
		
        super.tearDown()
    }

	func testCanCreateHearImageView() {
		XCTAssertNotNil(heartImageView, "Should be able to instantiate a heartImageView")
	}

}
