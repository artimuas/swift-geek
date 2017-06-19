//
//  Designable.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

@objc
public protocol Designable {
	var strokeWidth: CGFloat { get	set	}
	
	var strokeColor: UIColor { get set }
	
	var scaling: Double { get set }
	
	func setup()
	
}
