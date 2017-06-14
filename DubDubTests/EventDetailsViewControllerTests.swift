//
//  EventDetailsViewControllerTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/8/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class EventDetailsViewControllerTests: XCTestCase {
	
	var detailsViewController: EventDetailsViewController!
    
    override func setUp() {
        super.setUp()
		
		let storyboard = UIStoryboard(
			name: "Main", bundle: Bundle(for: EventDetailsViewController.self)
		)
		
		detailsViewController = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as! EventDetailsViewController
		
		let _ = detailsViewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
		detailsViewController = nil
			
        super.tearDown()
    }
    
	func testCanCreateEventDetailsViewController() {
		XCTAssertNotNil(detailsViewController, "Should be able to instantiate a EventDetailsViewController from the storyboard")
	}
	
}
