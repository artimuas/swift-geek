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
		
		context = CoreDataStack.sharedInstance.persistentContainer.viewContext
		event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event
    }
    
    override func tearDown() {
		event = nil
		context = nil
		
        super.tearDown()
    }
    
    func testEventCanParseEventJSON() {
        guard let eventsArray = loadJSONSample()?[EventKey.events] as? [JSON] 
            else { return }
        
        if let eventDict = eventsArray.first {
            event.parse(eventDict)
        }
        
        XCTAssertEqual(event.identifier, 3592642, "Should parse the event id from JSON")
        XCTAssertEqual(event.dateTimeLocal, DateFormatter.dateFrom(rfc3339String: "2017-06-16T19:05:00") as NSDate?, "Should parse the local event date from JSON")
        XCTAssertEqual(event.dateTimeUTC, DateFormatter.dateFrom(rfc3339String: "2017-06-17T00:05:00") as NSDate?, "Should parse utc data from JSON")
        XCTAssertEqual(event.imageURL?.absoluteString, "https://chairnerd.global.ssl.fastly.net/images/performers-landscape/seattle-mariners-46fcfb/13/huge.jpg", "Should parse the image url from JSON")
        XCTAssertEqual(event.title, "Seattle Mariners at Texas Rangers", "Should parse the title from JSON")
        XCTAssertEqual(event.type, "mlb", "Should parse the type from JSON")
        XCTAssertEqual(event.url?.absoluteString, "https://seatgeek.com/mariners-at-rangers-tickets/6-16-2017-arlington-texas-globe-life-park/mlb/3592642", "Should parse the url from JSON")
    }
	
	func testEventHasVenue() {
		guard let eventsArray = loadJSONSample()?[EventKey.events] as? [JSON]
			else { return }
		
		if let eventDict = eventsArray.first {
			event.parse(eventDict)
		}
		
		XCTAssertNotNil(event.venue, "Event should have a venue")
		
	}
	
}
