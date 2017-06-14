//
//  EventsListViewControllerTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class EventsListViewControllerTests: XCTestCase {
	
	var eventsListViewController: EventsListViewController!
	var searchController: UISearchController!
    
    override func setUp() {
        super.setUp()
		
		let storyboard = UIStoryboard(
			name: "Main",
			bundle: Bundle(for: EventsListViewController.self)
		)
		
		eventsListViewController = storyboard.instantiateViewController(
			withIdentifier: "EventsListViewController"
			) as? EventsListViewController
		
		let _ = eventsListViewController.loadViewIfNeeded()
				
		searchController = eventsListViewController.searchController
    }
    
    override func tearDown() {
		eventsListViewController = nil
		
        super.tearDown()
    }
	
	func testCanCreateEventsListViewcontroller() {
		XCTAssertNotNil(eventsListViewController, "Should be able to instantiate a EventsListViewcontroller from Main storyboard")
	}
	
	
	func testControllerHasSearchController() {
		guard searchController != nil else {
			return XCTFail("EventsListViewController should have a search controller")
		}
		
		guard let _ = searchController.delegate as? EventsListViewController
			else {
				return XCTFail("EventsListViewController should be the delegate for searchcontroller")
		}
		
		guard let _ = searchController.searchResultsUpdater as? EventsListViewController
			else {
				return XCTFail("EventsListViewController should be the search results updater for the searchcontroller")
		}
		
	}
	
	func testControllerSetsSearchBarAsTableViewHeader() {
		guard let headerView = eventsListViewController.tableView.tableHeaderView
			else {
				return XCTFail("EventsViewController should set the table header view")
		}
		
		XCTAssertEqual(headerView, searchController.searchBar, "Table's header view should be the search bar")
	}
}
