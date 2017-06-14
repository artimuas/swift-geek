//
//  HeartButton.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

@IBDesignable class HeartButton: UIButton, HeartDesignable {
	
	@IBInspectable open var strokeColor: UIColor = UIColor.clear
	@IBInspectable open var scaling: Double = 1.0
	@IBInspectable open var strokeWidth: CGFloat = 1.0
	@IBInspectable open var fillColor: UIColor = UIColor.clear
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setup()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setup()
	}
	
	open func setup() {
		drawHeart()
	}
}
