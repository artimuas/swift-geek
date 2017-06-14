//
//  AppDelegateTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/8/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class AppDelegateTests: XCTestCase {
	
	var delegate: AppDelegate!
    
    override func setUp() {
		delegate = UIApplication.shared.delegate as? AppDelegate
		
        super.setUp()
    }
    
    override func tearDown() {
		delegate = nil
		
        super.tearDown()
    }
	
	func testCanCreateAnAppDelegate() {
		XCTAssertNotNil(delegate, "Should be able to instantiate a application delegate")
	}
	
}
