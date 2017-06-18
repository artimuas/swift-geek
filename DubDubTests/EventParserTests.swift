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
        if let data = loadJSONSample() {
            parser.parse(data)
        }        
	}
	
}
