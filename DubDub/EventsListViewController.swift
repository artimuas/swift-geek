//
//  EventsListViewController.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class EventsListViewController: UITableViewController {
	
	var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()

		setupSearchController()
		
		let nib = UINib(nibName: EventTableViewCell.identifier, bundle: Bundle(for: EventsListViewController.self))
		tableView.register(nib, forCellReuseIdentifier: EventTableViewCell.identifier)
        
        let service = APIService()
        service.getEventsFor(query: "Texas", onPage: 1) { (result) in
            
        }
    }
	
	func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil) //passing nil sets current viewcontroller as the results controller
		searchController?.delegate = self
		searchController?.searchResultsUpdater = self
		
		tableView?.tableHeaderView = searchController?.searchBar
	}
	
}

//MARK: Table View Data Source

extension EventsListViewController{
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier) {
			return cell
		}
		
		return EventTableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 115
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 115
	}
}

//MARK: Table View Delegate

extension EventsListViewController {
	
}

// MARK: Search Controller Delegate

extension EventsListViewController: UISearchControllerDelegate {}


// MARK: Search Results Updating

extension EventsListViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		
	}
}

extension EventsListViewController {
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		print("Transitioning to \(size) and coordinator: \(coordinator)")
	}
}
