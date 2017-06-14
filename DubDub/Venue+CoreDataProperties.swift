//
//  Venue+CoreDataProperties.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var displayLocation: String?
    @NSManaged public var identifier: Int64
    @NSManaged public var name: String?
    @NSManaged public var url: NSURL?
    @NSManaged public var address: Address?
    @NSManaged public var event: Event?

}
