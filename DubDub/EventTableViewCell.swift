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
	
	@IBOutlet weak var headerImageView: UIImageView?
	@IBOutlet weak var favoriteImageView: HeartImageView?
	@IBOutlet weak var titleLabel: UILabel?
	@IBOutlet weak var locationLabel: UILabel?
	@IBOutlet weak var timeLabel: UILabel?
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
}
