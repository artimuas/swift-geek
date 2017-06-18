//
//  Venue+CoreDataProperties.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/17/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var displayLocation: String?
    @NSManaged public var identifier: Int
    @NSManaged public var name: String?
    @NSManaged public var url: NSURL?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var postal: String?
    @NSManaged public var country: String?
    @NSManaged public var street: String?
    @NSManaged public var event: Event?
    @NSManaged public var location: Location?

}
