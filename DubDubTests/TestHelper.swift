//
//  TestHelper.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/17/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
	func loadJSONSample() -> [String: AnyObject]? {
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "sample", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject]
            return json
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        return nil
    }
}
