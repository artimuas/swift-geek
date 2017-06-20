//
//  EventTableViewCellTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/13/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class EventTableViewCellTests: XCTestCase {
	
	var cell: EventTableViewCell!
    
    override func setUp() {
        super.setUp()
		
		let nib = UINib(nibName: "EventTableViewCell", bundle: Bundle(for:EventTableViewCell.self))
		
		cell = nib.instantiate(withOwner: nil, options: nil).first as? EventTableViewCell
		
		cell.layoutIfNeeded()

    }
    
    override func tearDown() {
		cell = nil
		
        super.tearDown()
    }
	
	func testCanCreateCellFromNib() {
		guard cell != nil else {
			return XCTFail("Should be able to instantiate a EventTableViewCell from its nib")
		}
		
		XCTAssertEqual(cell?.reuseIdentifier, "EventTableViewCell")
	}
		
}
