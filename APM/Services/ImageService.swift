//
//  ImageService.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class ImageService {
	static let shared = ImageService()
	private let cache = NSCache<NSString, UIImage>()

	func get(image link: String, completion: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: link) else { return }
		let qos = DispatchQoS.background.qosClass
		
		if let cached = cache.object(forKey: NSString(string: link)) {
			completion(cached)
			return
		}
		DispatchQueue.global(qos: qos).async {
			guard let data = try? Data(contentsOf: url) else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			guard let image = UIImage(data: data) else {
				DispatchQueue.main.async { completion(nil) }
				return
			}
			
			DispatchQueue.main.async { completion(image) }
			self.cache.setObject(image, forKey: NSString(string: link))
		}
	}
}
