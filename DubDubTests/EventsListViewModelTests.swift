//
//  EventsListViewModelTests.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/18/17.
//  Copyright © 2017 home. All rights reserved.
//

import XCTest
@testable import DubDub

class EventsListViewModelTests: XCTestCase {
    
    var viewModel: EventsListViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = EventsListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
}
