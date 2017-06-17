//
//  Parsable.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/16/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

public protocol Parsable {
	func parse(jsonData: Data?)
}
