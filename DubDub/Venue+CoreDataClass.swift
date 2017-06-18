//
//  Venue+CoreDataClass.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct VenueKey {
    static let city = "city"
    static let country = "country"
    static let displayLocation = "display_location"
    static let identifier = "id"
    static let name = "name"
    static let postalCode = "postal_code"
    static let state = "state"
    static let street = "address"
    static let url = "url"
    static let location = "location"
}


public class Venue: NSManagedObject, Parsable {
    
    public func parse(_ jsonData: [String : AnyObject]) {
        
        guard let identifier = jsonData[VenueKey.identifier] as? Int,
            let name = jsonData[VenueKey.name] as? String,
            let street = jsonData[VenueKey.street] as? String,
            let city = jsonData[VenueKey.city] as? String,
            let state = jsonData[VenueKey.state] as? String,
            let country = jsonData[VenueKey.country] as? String,
            let postalCode = jsonData[VenueKey.postalCode] as? String,
            let displayLocation = jsonData[VenueKey.displayLocation] as? String,
            let urlString = jsonData[VenueKey.url] as? String
            else { return }
        
        self.identifier = identifier
        self.name = name
        self.street = street
        self.city = city
        self.state = state
        self.country = country
        self.postal = postalCode
        self.displayLocation = displayLocation
        self.url = NSURL(string: urlString)
        
        if let locationDict = jsonData[VenueKey.location] as? JSON,
            let context = self.managedObjectContext {
            
            let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as? Location
            location?.parse(locationDict)
            
            self.location = location
            location?.venue = self
        }
    }
    
}
