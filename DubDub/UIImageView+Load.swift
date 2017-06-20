//
//  UIImageView+Load.swift
//  DubDub
//
//  Created by Saumitra Vaidya on 6/20/17.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

	func loadImageFrom(url: URL, placeHolderImage: UIImage?) {
		
		image = nil
		
		if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
			image = cachedImage
			return
		}
		
		URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
			
			if error != nil {
				DispatchQueue.main.async {
					self.image = placeHolderImage
				}
				return
			}
			
			DispatchQueue.main.async {
				if let data = data {
					if let downloadedImage = UIImage(data: data) {
						imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
						self.image = downloadedImage
					}
				}
			}
		}).resume()
	}
}
