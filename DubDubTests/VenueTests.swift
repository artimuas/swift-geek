//
//  VenueTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
import CoreData
@testable import DubDub

class VenueTests: XCTestCase {
    
    var venue: Venue!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        context = CoreDataStack.sharedInstance.persistentContainer?.viewContext
        venue = NSEntityDescription.insertNewObject(forEntityName: "Venue", into: context) as? Venue
    }
    
    override func tearDown() {
        venue = nil
        context = nil
        
        super.tearDown()
    }
        
    func testVenueCanParseVenueJSON() {
        guard let eventsArray = loadJSONSample()?[EventKey.events] as? [[String: AnyObject]],
            let venueDict = eventsArray[0][EventKey.venue] as? [String: AnyObject]
            else { return }
        
        venue.parse(venueDict)
        
        XCTAssertEqual(venue.identifier, 16, "Should parse the id appropriately from the JSON")
        XCTAssertEqual(venue.city, "Arlington", "Should parse the city appropriately from the JSON")
        XCTAssertEqual(venue.country, "US", "Should parse the country appropriately from the JSON")
        XCTAssertEqual(venue.name, "Globe Life Park", "Should parse the name appropriately from the JSON")
        XCTAssertEqual(venue.postal, "76011", "Should parse the postal code appropriately from the JSON")
        XCTAssertEqual(venue.state, "TX", "Should parse the state appropriately from the JSON")
        XCTAssertEqual(venue.street, "1000 Ballpark Way", "Should parse the street address appropriately from the JSON")
        XCTAssertEqual(venue.url?.absoluteString, "https://seatgeek.com/venues/globe-life-park/tickets", "Should parse the url appropriately from the JSON")
        XCTAssertEqual(venue.displayLocation, "Arlington, TX", "Should parse the display location appropriately from the JSON")
    }
}
