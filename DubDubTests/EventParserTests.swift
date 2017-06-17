//
//  EventParserTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class EventParserTests: XCTestCase {
	
	var parser: EventParser!
    
    override func setUp() {
        super.setUp()
		
		parser = EventParser()
    }
    
    override func tearDown() {
		parser = nil
		
        super.tearDown()
    }
	
	func testEventParserParsesDataAndAddsThemToContext() {
		let data = loadJSONSample()
		parser.parse(jsonData: data)
	}
	
}


extension EventParserTests {
	
	func loadJSONSample() -> Data? {
		
		let bundle = Bundle(for: type(of: self))
		guard let url = bundle.url(forResource: "sample", withExtension: "json") else {
			XCTFail("Unable to load sample.json")
			return nil
		}
		
		do {
			let data = try Data(contentsOf: url)
			return data
		} catch {
			print("Error: \(error.localizedDescription)")
		}
		
		return nil
	}
}
