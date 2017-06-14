//
//  UIBezierPath+Heart.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/14/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

public extension UIBezierPath {
	
	func heartPath(_ originalRect: CGRect, scale: Double) -> UIBezierPath {
		
		let scaledWidth = (originalRect.size.width * CGFloat(scale))
		let scaledX = (originalRect.size.width - scaledWidth) / 2
		
		let scaledHeight = (originalRect.size.height * CGFloat(scale))
		let scaledY = (originalRect.size.height - scaledHeight) / 2
		
		let scaledRect = CGRect(x: scaledX, y: scaledY, width: scaledWidth, height: scaledHeight)
		
		self.move(to: CGPoint(x: originalRect.size.width/2, y: scaledRect.origin.y + scaledRect.size.height))

		self.addCurve(to: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height/4)),
		              controlPoint1:CGPoint(x: scaledRect.origin.x + (scaledRect.size.width/2), y: scaledRect.origin.y + (scaledRect.size.height*3/4)),
		              controlPoint2: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height/2)) )
		
		self.addArc(withCenter: CGPoint( x: scaledRect.origin.x + (scaledRect.size.width/4),y: scaledRect.origin.y + (scaledRect.size.height/4)),
		            radius: (scaledRect.size.width/4),
		            startAngle: CGFloat(Double.pi),
		            endAngle: 0,
		            clockwise: true)
		
		self.addArc(withCenter: CGPoint( x: scaledRect.origin.x + (scaledRect.size.width * 3/4),y: scaledRect.origin.y + (scaledRect.size.height/4)),
		            radius: (scaledRect.size.width/4),
		            startAngle: CGFloat(Double.pi),
		            endAngle: 0,
		            clockwise: true)
		
		self.addCurve(to: CGPoint(x: originalRect.size.width/2, y: scaledRect.origin.y + scaledRect.size.height),
		              controlPoint1: CGPoint(x: scaledRect.origin.x + scaledRect.size.width, y: scaledRect.origin.y + (scaledRect.size.height/2)),
		              controlPoint2: CGPoint(x: scaledRect.origin.x + (scaledRect.size.width/2), y: scaledRect.origin.y + (scaledRect.size.height*3/4)) )
		
		self.close()
		
		return self
		
	}
	
}
