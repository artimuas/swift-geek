//
//  Location+CoreDataClass.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import CoreData

struct LocationKey {
    static let location = "location"
    static let latitude = "lat"
    static let longitude = "lon"
}

public class Location: NSManagedObject, Parsable {
    
    public func parse(_ jsonData: [String : AnyObject]) {
        
        guard let latitude = jsonData[LocationKey.latitude] as? Double,
            let longitude = jsonData[LocationKey.longitude] as? Double
            else { return }
        
        self.latitude = latitude
        self.longitude = longitude
        
    }
}
