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
    @IBOutlet weak private var titleLabel: UILabel!
    
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
		
        navigationItem.leftItemsSupplementBackButton = true
        navigationController?.navigationBar.clipsToBounds = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func updateView() {
        if let title = event?.title {
            titleLabel.text = title
        }
        
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
            navigationItem.rightBarButtonItem?.tintColor = UIColor.heartColor
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
