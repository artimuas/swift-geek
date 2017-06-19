//
//  EventsListViewController.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import CoreData

class EventsListViewController: UITableViewController {
	
	var searchController: UISearchController?
    
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Event.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateTimeLocal", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", EventKey.title, (self.searchController?.searchBar.text)!)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    lazy var service = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()

		setupSearchController()
		
		let nib = UINib(nibName: EventTableViewCell.identifier, bundle: Bundle(for: EventsListViewController.self))
		tableView.register(nib, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
	
	func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil) //passing nil sets current viewcontroller as the results controller
		searchController?.delegate = self
		searchController?.searchResultsUpdater = self
		searchController?.searchBar.placeholder = "Search for your favorite teams"
		tableView?.tableHeaderView = searchController?.searchBar
	}
	
}

// MARK: Table View Data Source

extension EventsListViewController {
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier) as? EventTableViewCell {
            
            if let event = fetchedResultsController.object(at: indexPath) as? Event {
                cell.configureCellWith(event: event)
            }
            
            return cell
		}
		
		return EventTableViewCell()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedResultsController.fetchedObjects?.count {
            return count
        }
		return 0
	}
	
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 115
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 115
	}
}

// MARK: Table View Delegate

extension EventsListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: Fetched Results Controller Delegate

extension EventsListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex) , with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

// MARK: Search Controller Delegate

extension EventsListViewController: UISearchControllerDelegate {}


// MARK: Search Results Updating

extension EventsListViewController: UISearchResultsUpdating {
    
	func updateSearchResults(for searchController: UISearchController) {
        do {
            try fetchedResultsController.performFetch()
        } catch let error  {
            print("Error while performing fetch: \(error.localizedDescription)")
        }
            
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            updateFetchRequestWith(searchText)
            
            service.getEventsFor(query: searchText, onPage: 1) { (result) in
                print(result)
            }
        }
	}
    
    func updateFetchRequestWith(_ query: String?) {
        let fetchRequest = fetchedResultsController.fetchRequest
        fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", EventKey.title, query ?? "") 
    }
}
