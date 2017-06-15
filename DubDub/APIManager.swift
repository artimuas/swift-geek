//
//  APIManager.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/15/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

enum Endpoint: String {
	case events
}

struct APIManager {
	
	private static let baseURL = NSURL(string: "https://api.seatgeek.com/2/")
	private static let clientId = "Nzc3NDQwMnwxNDk2ODcwMjI0LjUx"
	
	private static func apiURL(to endpoint: Endpoint, parameters: [String: String]?) -> URL? {
		
		return nil
		
	}
	
	static var eventsURL: URL {
		return apiURL(to: .events, parameters: ["type": "mlb"])!
	}
}
