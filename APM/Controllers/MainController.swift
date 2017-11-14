//
//  MainController.swift
//  APM
//
//  Created by Alexandre LEGENT on 14/11/2017.
//  Copyright © 2017 Alexandre Legent. All rights reserved.
//

import UIKit

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	private let scrollController = ScrollController()
	private let cellId = "cellId"
	private let links = [
		"https://www.nasa.gov/sites/default/files/thumbnails/image/neutron_star_merger_still_3.jpg",
		"https://www.nasa.gov/sites/default/files/thumbnails/image/ksc-20171016-ph_csh01_0005_0.jpg",
		"https://www.nasa.gov/sites/default/files/thumbnails/image/as4-01-580.jpg",
		"https://www.nasa.gov/sites/default/files/thumbnails/image/pia22104.jpg",
		"https://www.nasa.gov/sites/default/files/thumbnails/image/pia22043.jpg",
		"https://www.nasa.gov/sites/default/files/thumbnails/image/iss053e023965.jpg",
		"https://www.nasa.gov/sites/default/files/thumbnails/image/21457942_1775841795789423_6361884645929817029_o.jpg"
	]
	
	let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "APM"
		view.backgroundColor = .white
		view.addSubview(collectionView)
		setupLayouts()
		setupCollectionView()
	}
	
	private func setupLayouts() {
		_ = collectionView.constraint(.top, to: view)
		collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
	
	private func setupCollectionView() {
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .clear
		collectionView.register(PictureCell.self, forCellWithReuseIdentifier: cellId)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return links.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PictureCell
		cell.link = links[indexPath.item]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		ImageService.shared.get(image: links[indexPath.item]) { image in
			self.scrollController.image = image
			self.navigationController?.pushViewController(self.scrollController, animated: true)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 9 / 16)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

