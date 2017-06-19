//
//  EventParser.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct DataManager: Parsable {
    
    func parse(_ jsonData: JSON) {
        guard let eventsArray = jsonData[EventKey.events] as? [JSON]
            else { return }
        
        let container = CoreDataStack.sharedInstance.persistentContainer
        
        container.performBackgroundTask({ (context) in
			
			for eventDict in eventsArray {
				
				if let id = eventDict["id"] as? Int {
					self.findEventWith(id: id, completion: { (event) in
						if let event = event {
							print("Event found: \(event.identifier)")
						} else {
							let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event
							event?.parse(eventDict)
						}
					})
				}
			}
		})
    }
	
	private func findEventWith(id: Int, completion: (Event?) -> Void) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Event.self))
		fetchRequest.predicate = NSPredicate(format: "%K == %d", "identifier", id)
		do {
			let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
			let event = try context.fetch(fetchRequest).first as? Event
			if let event = event {
    			completion(event)
			} else {
				completion(nil)
			}
		} catch {
			print("Error fetching Event object from CoreData: \(error.localizedDescription)")
		}
	}
	
}
