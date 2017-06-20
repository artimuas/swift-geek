//
//  UIViewController+Additions.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/20/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
	
	public var visibleViewController: UIViewController? {
		return UIWindow.visibleViewController(from: rootViewController)
	}
	
	public static func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
		switch viewController {
		case let navigationController as UINavigationController:
			return UIWindow.visibleViewController(from: navigationController.visibleViewController)
		case let tabBarController as UITabBarController:
			return UIWindow.visibleViewController(from: tabBarController.selectedViewController)
		case let presentingViewController where viewController?.presentedViewController != nil:
			return UIWindow.visibleViewController(from: presentingViewController?.presentedViewController)
		default:
			return viewController
		}
	}
}
