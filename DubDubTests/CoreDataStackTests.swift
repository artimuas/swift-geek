//
//  CoreDataStackTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class CoreDataStackTests: XCTestCase {
	
	var stack: CoreDataStack!
	
    override func setUp() {
        super.setUp()
		
		stack = CoreDataStack.sharedInstance
    }
    
    override func tearDown() {
        stack = nil
		
        super.tearDown()
    }
	
	func testCanCreateCoreDataStack() {
		XCTAssertNotNil(stack, "Should be able to create an instance of CoreDataStack")
	}
	
	func testCoreDataStackHasPersistentContainer() {
		guard let container = CoreDataStack.sharedInstance.persistentContainer else {
			return XCTFail("CoreData stack should have a persistent container")
		}
		
		XCTAssertEqual(container.name, "DubDub", "The persistent container should be named appropriately")
	}
	
}
