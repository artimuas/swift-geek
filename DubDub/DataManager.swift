//
//  EventParser.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct DataManager {
    
    static func saveData() {
        CoreDataStack.sharedInstance.saveContext()
    }
    
    func processJSON(_ jsonData: JSON) {
        let eventsManager = EventsManager()
        eventsManager.parse(jsonData)
    }
        
}
