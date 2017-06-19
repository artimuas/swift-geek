//
//  CoreDataStackTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
import CoreData
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
        let container = CoreDataStack.sharedInstance.persistentContainer 
        
        XCTAssertEqual(container.name, "DubDub", "The persistent container should be named appropriately")
	}
    
    func testStackShouldSaveContext() {
        let context = stack.persistentContainer.viewContext 
        
        empty(context)
        guard let eventsArray = loadJSONSample()?[EventKey.events] as? [JSON] 
            else { return }
        
        let _ = eventEntityFrom(eventsArray: eventsArray, inContext: context)
        stack.saveContext()
        
        let events = fetchEventsFrom(context: context)
        XCTAssertEqual(events.count, 1, "There should be one event saved in the store")
    }
	
}

extension CoreDataStackTests {
    
    func empty(_ context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        do {
            let allObjects = try context.fetch(fetchRequest) as? [NSManagedObject]
            _ = allObjects.map{$0.map{context.delete($0)}}
        } catch {
            print("Error deleting objects from context")
        }
    }
    
    func eventEntityFrom(eventsArray: [[String: AnyObject]], inContext context: NSManagedObjectContext) -> Event? {
        
        let eventDict = eventsArray.first
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event
        event?.parse(eventDict!)
        
        return event
    }
    
    func fetchEventsFrom(context: NSManagedObjectContext) -> [Event] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        var results = [Event]()
        do {
            results = try context.fetch(fetchRequest) as! [Event]
        } catch  {
            fatalError()
        }
        
        return results
    }
}
