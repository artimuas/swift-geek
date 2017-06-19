//
//  EventParser.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct EventParser: Parsable {
    
    func parse(_ jsonData: JSON) {
        guard let eventsArray = jsonData[EventKey.events] as? [JSON]
            else { return }
        
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        context.perform {
            for eventDict in eventsArray {
                let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event
                event?.parse(eventDict)
            }
        }
    }
    
}
