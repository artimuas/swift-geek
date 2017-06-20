//
//  EventDetailsViewController.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/8/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {

	@IBOutlet weak private var headerImageView: UIImageView!
	@IBOutlet weak private var timeLabel: UILabel!
	@IBOutlet weak private var cityLabel: UILabel!
    
    var event: Event?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
		
		navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerImageView.layer.masksToBounds = true
        headerImageView.layer.cornerRadius = 10
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func updateView() {
		title = event?.title
		
		if let url = event?.imageURL as URL? {
			headerImageView.loadImageFrom(url: url, placeHolderImage: nil)
		}
		
        if let dateTimeLocal = event?.dateTimeLocal as Date? {
            self.timeLabel.text = DateFormatter.dateTimeStringFrom(date: dateTimeLocal)
        }
        
        if let venue = event?.venue {
            self.cityLabel.text = "\(venue.city ?? "City"), \(venue.state ?? "St")"
        }
        
        updateFavoriteButton()
    }
    
    fileprivate func updateFavoriteButton() {
        if event?.favorite == true {
            navigationItem.rightBarButtonItem?.tintColor = UIColor(red: (255/255), green: (110/255), blue: (87/255), alpha: 1.0)
        } else {
            navigationItem.rightBarButtonItem?.tintColor = UIColor(white: 0.5, alpha: 1)
        }
    }

    @IBAction func favorite(_ sender: Any) {        
        guard let event = event else { return }
        
        event.favorite = !(event.favorite)
        
        updateFavoriteButton()
    }
}
