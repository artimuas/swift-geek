//
//  EventManager.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/19/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct EventsManager: Parsable {
    
    func parse(_ jsonData: JSON) {

        guard let eventsArray = jsonData[EventKey.events] as? [JSON]
            else { return }
        let container = CoreDataStack.sharedInstance.persistentContainer
        
        container.performBackgroundTask({ context in
            
            for eventDict in eventsArray {
                
                if let id = eventDict["id"] as? Int {
                    self.findEventWithId(id, completion: { (event) in
                        if let event = event {
                            self.updateEvent(event, withDictionary: eventDict)
                        } else {
                            self.createNewEvent(fromDictionary: eventDict)
                        }
                    })
                }
            }
            
            DataManager.saveData()
        })
        
    }
 
    private func findEventWithId(_ id: Int, completion: (Event?) -> Void) {
        
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
    
    private func createNewEvent(fromDictionary eventDict: [String: AnyObject]) {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event
        
        if let event = event {
            updateEvent(event, withDictionary: eventDict)
        }
   }
    
    func updateEvent(_ event: Event, withDictionary eventDict: [String: AnyObject]) {
        event.parse(eventDict)
    }
    
}
