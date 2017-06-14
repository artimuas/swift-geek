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
	
	func testCellHasHeaderImageView() {
		guard let imageView = cell.headerImageView else { return XCTFail("Cell should have a headerImageView")
		}
		
		XCTAssertFalse(imageView.isHidden, "Cell's header image view should not be hidden")
		
		XCTAssertTrue(imageView.contentMode == UIViewContentMode.scaleAspectFit, "Header image view's content mode should be scaleAspectFit")
	}
	
	func testCellHasFavoriteImageView() {
		guard let imageView = cell.favoriteImageView else { return XCTFail("Cell should have a favorite image view")
		}
		
		XCTAssertTrue(imageView.isHidden, "Cell's favorite image view should be hidden by default")
		
		XCTAssertTrue(imageView.contentMode == UIViewContentMode.scaleAspectFit, "Header image view's content mode should be scaleAspectFit")
	}
	
}
