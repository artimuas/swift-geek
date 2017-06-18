//
//  NSDateFormatter+Additions.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/17/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let rfc3339dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    class func dateFrom(rfc3339String: String) -> Date? {
        return rfc3339dateFormatter.date(from: rfc3339String)
    }

}
