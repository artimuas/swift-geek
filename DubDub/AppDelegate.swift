//
//  AppDelegate.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/6/17.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		configureAppearance()
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
        CoreDataStack.sharedInstance.saveContext()
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
        CoreDataStack.sharedInstance.saveContext()
	}

	func applicationWillTerminate(_ application: UIApplication) {
		CoreDataStack.sharedInstance.saveContext()
	}
	
	private func configureAppearance() {
		// Appearance
		
		UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor.white
		UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).barTintColor = UIColor(red: (25/255), green: (53/255), blue: (111/255), alpha: 0.75)

	}

}

