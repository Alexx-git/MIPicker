//
//  AlbumPreviewView.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit


class AlbumPreviewView: UIView {
	
	var imageViews: Array<UIImageView> = []
	
	
	init (viewCount: Int = 3, gap: CGFloat = 3.0)
	{
		super.init(frame: .zero)
		self.clearPreviews()
		let defaultSideInset = CGFloat(viewCount) * gap / 2
		for counter in 0..<viewCount
		{
			let imageView = UIImageView()
			self.addSubview(imageView)
			let sideInset = defaultSideInset + CGFloat(counter) * gap
			let topInset = CGFloat(viewCount - counter) * gap
			let bottomInset = CGFloat(counter) * gap * 3
			imageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: topInset, left: sideInset, bottom: bottomInset, right: sideInset))
			self.sendSubviewToBack(imageView)
			imageViews.append(imageView)
		}
	}
	
	func set(image: UIImage, forViewAt number: Int)
	{
		imageViews[number].image = image
	}
	
	
	convenience init(images: Array<UIImage>, gap: CGFloat = 3.0)
	{
		
		self.init(viewCount: images.count, gap: gap)
		for (number, image) in images.enumerated()
		{
			self.set(image: image, forViewAt: number)
		}
	}

	func clearPreviews()
	{
		for imageView in imageViews
		{
			imageView.removeFromSuperview()
		}
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
