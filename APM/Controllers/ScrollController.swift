//
//  ScrollController.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class ScrollController: UIViewController, UIScrollViewDelegate {
	var minimumZoom: CGFloat {
		guard let image = image else { return 0 }
		return min(view.frame.width / image.size.width, view.frame.height / image.size.height)
	}
	
	var image: UIImage? {
		didSet {
			picture.image = image
			scrollView.contentSize = image?.size ?? .zero
			scrollView.maximumZoomScale = 100
			scrollView.minimumZoomScale = minimumZoom < 1 ? minimumZoom : 1
			scrollView.zoomScale = minimumZoom < 1 ? minimumZoom : 1
		}
	}
	
	let picture: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	let scrollView: UIScrollView = {
		let view = UIScrollView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(scrollView)
		scrollView.addSubview(picture)
		scrollView.delegate = self
		setupLayouts()
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return picture
	}
	
	private func setupLayouts() {
		_ = scrollView.constraint(.top, to: view)
		scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
}
