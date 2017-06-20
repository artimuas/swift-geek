//
//  CoreDataStack.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import CoreData
import Foundation

class CoreDataStack: NSObject {
	
	static let sharedInstance = CoreDataStack()
	
	private override init() {}
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "DubDub")
		
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		
		return container
	}()
	
    func saveContext () {
        
        let context = persistentContainer.viewContext
		
		context.performAndWait {
			if context.hasChanges {
				do {
					try context.save()
				} catch {
					let nserror = error as NSError
					fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
				}
			}
		}
    }

}
