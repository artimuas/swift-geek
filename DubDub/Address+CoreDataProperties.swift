//
//  Address+CoreDataProperties.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var postal: String?
    @NSManaged public var state: String?
    @NSManaged public var street: String?
    @NSManaged public var location: Location?
    @NSManaged public var venue: Venue?

}
