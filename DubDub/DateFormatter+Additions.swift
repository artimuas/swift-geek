//
//  NSDateFormatter+Additions.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/17/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    private static let rfc3339dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    private static let dateStringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "E, d MMM YYYY hh:mm a"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }()
    
    static func dateFrom(rfc3339String: String) -> Date? {
        return rfc3339dateFormatter.date(from: rfc3339String)
    }
    
    static func dateTimeStringFrom(date: Date) -> String? {
        return dateStringDateFormatter.string(from:date)
    }

}
