//
//  EventTableViewCell.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/13/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class EventTableViewCell: UITableViewCell {
	
	static let identifier = "EventTableViewCell"
	
	@IBOutlet weak private var labelStackView: UIStackView!
	@IBOutlet weak private var headerImageView: UIImageView!
	@IBOutlet weak private var favoriteImageView: HeartImageView!
	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var locationLabel: UILabel!
	@IBOutlet weak private var timeLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()

		headerImageView.layer.masksToBounds = true
		headerImageView.layer.cornerRadius = 10
        
        self.separatorInset = UIEdgeInsets.zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func heightFor(event: Event) -> CGFloat{
		
		let stackViewSize = labelStackView.bounds.size
		
		var titleString = ""
		if let title = event.title {
			titleString = title
		}
		let titleSize = titleString.boundingRect(with: stackViewSize, options: .usesFontLeading, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 15)!], context: nil).size

		var cityString = ""
		if let venue = event.venue {
			cityString = "\(venue.city ?? "City"), \(venue.state ?? "St")"
		}
		let cityStringSize = cityString.boundingRect(with: stackViewSize, options: .usesFontLeading, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 14)!], context: nil).size

		var dateTimeString = ""
		if let dateTimeLocal = event.dateTimeLocal as Date? {
			dateTimeString = DateFormatter.dateTimeStringFrom(date: dateTimeLocal)!
		}
		let dateTimeSize = dateTimeString.boundingRect(with: stackViewSize, options: .usesFontLeading, attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 14)!], context: nil).size
		
		return titleSize.height + cityStringSize.height + dateTimeSize.height + 40
		
	}

    func configureCellWith(event: Event) {
		
		if let url = event.imageURL as URL? {
			headerImageView.loadImageFrom(url: url, placeHolderImage: nil)
		}
		
        titleLabel.text = event.title
		
        if let dateTimeLocal = event.dateTimeLocal as Date? {
            timeLabel.text = DateFormatter.dateTimeStringFrom(date: dateTimeLocal)
        }
        
        if let venue = event.venue {
            locationLabel.text = "\(venue.city ?? "City"), \(venue.state ?? "St")"
        }
        
        favoriteImageView.isHidden = !event.favorite
    }
}
