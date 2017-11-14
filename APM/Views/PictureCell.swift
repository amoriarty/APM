//
//  PictureCell.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class PictureCell: UICollectionViewCell {
	var link: String? {
		didSet {
			guard let link = link else { return }
			indicator.startAnimating()
			ImageService.shared.get(image: link) { image in
				self.indicator.stopAnimating()
				self.picture.image = image
			}
		}
	}
	
	let picture: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	let indicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.translatesAutoresizingMaskIntoConstraints = false
		indicator.hidesWhenStopped = true
		indicator.color = .black
		return indicator
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
		addSubview(picture)
		addSubview(indicator)
		_ = picture.fill(self)
		_ = indicator.center(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
