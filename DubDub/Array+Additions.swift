//
//  Array+Additions.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/15/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

extension Array where Element == URLQueryItem {
    
    mutating func addParameters(dictionary: [String: Any?]) {
        for (key, value) in dictionary {
            if let val = value as? String {
                let item = URLQueryItem(name: key, value: val)
                self.append(item)
                continue
            }
            
            if let val = value as? Int {
                let item = URLQueryItem(name: key, value: String(val))
                self.append(item)
                continue
            }
        }
    }
}
