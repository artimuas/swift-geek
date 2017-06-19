//
//  EventsListViewModel.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/18/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import CoreData

class EventsListViewModel: NSObject, NSFetchedResultsControllerDelegate {
    
    lazy var context: NSManagedObjectContext = { 
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }()
    

    lazy var fetchResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Event.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: EventKey.dateTimeLocal, ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
}
