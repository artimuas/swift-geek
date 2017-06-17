//
//  EventTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
import CoreData
@testable import DubDub

class EventTests: XCTestCase {
	
	var context: NSManagedObjectContext!
	var event: Event!
    
    override func setUp() {
        super.setUp()
		
		context = CoreDataStack.sharedInstance.persistentContainer?.viewContext
		event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event
    }
    
    override func tearDown() {
		event = nil
		context = nil
		
        super.tearDown()
    }
    
	func testCanCreateEventEntity() {
		XCTAssertNotNil(event, "Should be able to create a new managed object for Event entity")
	}
	
	
}
