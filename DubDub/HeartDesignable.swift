//
//  HeartDesignable.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

@objc
public protocol HeartDesignable: Designable {
	var fillColor: UIColor { get set }
}

public extension HeartDesignable where Self: UIView {
    
	func drawHeart() {
		layer.sublayers?
			.forEach { $0.removeFromSuperlayer()
		}
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.backgroundColor = UIColor.clear.cgColor
		shapeLayer.name = "Heart"
		shapeLayer.path = UIBezierPath().heartPath(frame, scale: scaling).cgPath
		
		shapeLayer.lineWidth = strokeWidth
		shapeLayer.strokeColor = strokeColor.cgColor
		shapeLayer.fillColor = fillColor.cgColor
		self.layer.addSublayer(shapeLayer)

	}
}
