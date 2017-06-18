//
//  Event+CoreDataClass.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct EventKey {
    static let events = "events"
    static let dateTimeLocal = "datetime_local"
    static let dateTimeUTC = "datetime_utc"
    static let identifier = "id"
    static let imageURL = "image"
    static let performers = "performers"
    static let title = "title"
    static let type = "type"
    static let url = "url"
    static let venue = "venue"
}


public class Event: NSManagedObject, Parsable {
	
    public func parse(_ jsonData: [String : AnyObject]) {
        
        guard let identifier = jsonData[EventKey.identifier] as? Int,
            let title = jsonData[EventKey.title] as? String,
            let type = jsonData[EventKey.type] as? String,
            let performers = jsonData[EventKey.performers] as? [[String: AnyObject]],
            let imageURLString = performers[0][EventKey.imageURL] as? String
        else { return }
        
        self.identifier = identifier
        self.title = title
        self.type = type
        self.imageURL = NSURL(string: imageURLString)
        
        if let urlString = jsonData[EventKey.url] as? String {
            self.url = NSURL(string: urlString)
        }
        
        if let dateTimeUTCString = jsonData[EventKey.dateTimeUTC] as? String {
            self.dateTimeUTC = DateFormatter.dateFrom(rfc3339String: dateTimeUTCString) as NSDate?
        }
        
        if let dateTimeLocalString = jsonData[EventKey.dateTimeLocal] as? String {
            self.dateTimeLocal = DateFormatter.dateFrom(rfc3339String: dateTimeLocalString) as NSDate?
        }
        
        if let venueDict = jsonData[EventKey.venue] as? [String: AnyObject], 
            let context = self.managedObjectContext {
            
            let venue = NSEntityDescription.insertNewObject(forEntityName: "Venue", into: context) as? Venue
            venue?.parse(venueDict)
            
            self.venue = venue
            venue?.event = self
        }

    }
}
