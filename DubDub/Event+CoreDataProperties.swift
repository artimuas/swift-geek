//
//  Event+CoreDataProperties.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/17/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var dateTimeLocal: NSDate?
    @NSManaged public var dateTimeUTC: NSDate?
    @NSManaged public var favorite: Bool
    @NSManaged public var identifier: Int
    @NSManaged public var image: NSData?
    @NSManaged public var imageURL: NSURL?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var url: NSURL?
    @NSManaged public var venue: Venue?
    
}
