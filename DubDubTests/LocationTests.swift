//
//  LocationTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
import CoreData
@testable import DubDub

class LocationTests: XCTestCase {
	
	var context: NSManagedObjectContext!
	var location: Location!
    
    override func setUp() {
        super.setUp()
		
		context = CoreDataStack.sharedInstance.persistentContainer?.viewContext
		location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as? Location
    }
    
    override func tearDown() {
		location = nil
		context = nil
		
        super.tearDown()
    }
	
	func testCanCreateLocationEntity() {
		XCTAssertNotNil(location, "Should be able to instantiate a location entity from context")
	}
	
}
