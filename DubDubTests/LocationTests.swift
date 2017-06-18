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
	
    func testLocationCanParseLocationJSON() {
        guard let eventsArray = loadJSONSample()?[EventKey.events] as? [[String: AnyObject]],
            let venueDict = eventsArray[0][EventKey.venue] as? [String: AnyObject],
            let locationDict = venueDict[VenueKey.location] as? [String: AnyObject]
            else { return }
        
        location.parse(locationDict)
        
        XCTAssertEqual(location.latitude, 32.7506, "Should parse and set the location's latitude")
        XCTAssertEqual(location.longitude, -97.0824, "Should parse and set the location's latitude")
    }
    
}
