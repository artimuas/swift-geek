//
//  Dictionary+Keys.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/17/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

extension Dictionary {
    
    subscript(key: APIKeys) -> Value? {
        get {
            return self[String(describing: key) as! Key]
        }
        set(value) {
            guard
                let value = value else {
                    self.removeValue(forKey: String(describing: key) as! Key)
                    return
            }
            
            self.updateValue(value, forKey: String(describing: key) as! Key)
        }
    }
    
}

protocol APIKeys {}
