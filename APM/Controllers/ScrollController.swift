//
//  ScrollController.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

final class ScrollController: UIViewController {
    private let scrollView = UIScrollView()
    
	private var minimumZoom: CGFloat {
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
	
	private let picture: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		view.addSubview(scrollView)
		scrollView.addSubview(picture)
		scrollView.delegate = self
		_ = scrollView.fill(view.safeAreaLayoutGuide)
	}
}

extension ScrollController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return picture
    }
}
