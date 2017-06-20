//
//  EventsListViewController.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import CoreData

class EventsListViewController: UITableViewController, UITheme {
	
	fileprivate let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
	
	fileprivate lazy var service = APIService()

	var searchController: UISearchController?

	var themeColor = UIColor(red: (25/255), green: (53/255), blue: (111/255), alpha: 0.75)
	
	lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Event.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateTimeLocal", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupSearchController()
		
		let nib = UINib(nibName: EventTableViewCell.identifier, bundle: Bundle(for: EventsListViewController.self))
		tableView.register(nib, forCellReuseIdentifier: EventTableViewCell.identifier)
		tableView.tableFooterView = UIView()
		
        loadData()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		configureUI()
	}
	
	private func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil) //passing nil sets current viewcontroller as the results controller
		searchController?.delegate = self
		searchController?.searchResultsUpdater = self
		searchController?.dimsBackgroundDuringPresentation = false
		searchController?.hidesNavigationBarDuringPresentation = false
		searchController?.searchBar.searchBarStyle = .minimal
		searchController?.searchBar.placeholder = "Search for your favorite teams"
		
		navigationItem.titleView = searchController?.searchBar
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEventDetailsSegue", let event = sender as? Event {
            let detailsViewController = segue.destination as! EventDetailsViewController
            detailsViewController.event = event
        }
    }
    
    fileprivate func loadData() {
        do {
            try fetchedResultsController.performFetch()
			print("Events count:\((fetchedResultsController.fetchedObjects?.count)!)")
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
        } catch let error  {
            print("Error while performing CoreData fetch: \(error.localizedDescription)")
        }
    }
	
	fileprivate func displayError(_ error: Error) {
		let alertController = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		
		DispatchQueue.main.async {
			if let visibleController = UIApplication.shared.keyWindow?.visibleViewController {
				if let _ = visibleController as? UIAlertController {
					print("showing an alert already")
				} else {
					visibleController.present(alertController, animated: true, completion: nil)
				}
			}
		}
	}
	
	private func configureUI() {
		// Appearance
		
		navigationController?.navigationBar.barTintColor = themeColor
		
		searchController?.searchBar.tintColor = UIColor.white
		searchController?.searchBar.barTintColor = themeColor
		let searchField = searchController?.searchBar.value(forKey: "searchField") as? UITextField
		searchField?.textColor = UIColor.white
		
		// Backbutton
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)		
	}
	
}

// MARK: Table View Data Source

extension EventsListViewController {
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
		
		if let event = fetchedResultsController.object(at: indexPath) as? Event {
			cell.configureCellWith(event: event)
		}

		return cell

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
		
		if let event = fetchedResultsController.object(at: indexPath) as? Event,
			let cell = tableView.cellForRow(at: indexPath) as? EventTableViewCell {
			return cell.heightFor(event: event)
		}
		
		return 115
	}
}

// MARK: Table View Delegate

extension EventsListViewController {
	
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
		
		let selectedEvent = fetchedResultsController.object(at: indexPath)
		
		performSegue(withIdentifier: "ShowEventDetailsSegue", sender: selectedEvent)
    }

	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		if let count = fetchedResultsController.fetchedObjects?.count, indexPath.row == count - 2 { //Looking ahead
			fetchMoreEvents()
		}
	}
	
	override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		
		guard let event = self.fetchedResultsController.object(at: indexPath) as? Event else { return nil }

		let favoriteAction = UITableViewRowAction(style: .normal, title: (event.favorite ? "Unfavorite" : "Favorite")) { (action, indexPath) in
			event.favorite = !(event.favorite)
		}
		
		favoriteAction.backgroundEffect = UIBlurEffect(style: .prominent)
		
		if event.favorite == true {
			favoriteAction.backgroundColor = UIColor(red: (255/255), green: (110/255), blue: (87/255), alpha: 1.0)
		} else {
			favoriteAction.backgroundColor = UIColor(white: 0.5, alpha: 1)
		}
		
		return [favoriteAction]
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
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

extension EventsListViewController: UISearchControllerDelegate {
	
	func didDismissSearchController(_ searchController: UISearchController) {
		print("Search controller dismissed")
	}
}


// MARK: Search Results Updating

extension EventsListViewController: UISearchResultsUpdating {
    
	func updateSearchResults(for searchController: UISearchController) {

        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            updateFetchRequestWith(searchText)
			
			fetchEventsFor(query: searchText)
        }
                    	
		loadData()
    }
    
    func updateFetchRequestWith(_ query: String?) {
        let fetchRequest = fetchedResultsController.fetchRequest
        fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", EventKey.title, query ?? "")
    }
}

// MARK: API Service

extension EventsListViewController {

	fileprivate func fetchMoreEvents() {
		service.getEventsOnNextPage { (result) in
			self.processAPIResponse(result)
		}
	}
	
	fileprivate func fetchEventsFor(query: String) {
		service.getEventsFor(query: query) { (result) in
			self.processAPIResponse(result)
		}
	}
	
	func processAPIResponse(_ result: Result) {
		switch result {
		case .success(let response):
			print(response)
		//No need to do anything since FRC will take care of updating the table
		case .failure(let error):
			print(error.localizedDescription)
			displayError(error)
		}
	}
}
