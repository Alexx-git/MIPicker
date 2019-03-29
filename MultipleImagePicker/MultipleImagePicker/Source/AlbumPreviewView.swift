//
//  AlbumPreviewView.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit
import PureLayout


class AlbumPreviewView: UIView {
	
	var imageViews: Array<UIImageView> = []
    
    private var gap:CGFloat = 3.0
	
	
	init (viewCount: Int = 3, viewGap: CGFloat = 3.0)
	{
		super.init(frame: .zero)
		self.clearPreviews()
        gap = viewGap
		let defaultSideInset = CGFloat(viewCount) * gap / 2
		for counter in 0..<viewCount
		{
			let imageView = UIImageView()
			self.addSubview(imageView)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
			let sideInset = defaultSideInset + CGFloat(counter) * gap
			let topInset = CGFloat(viewCount - counter) * gap
			let bottomInset = CGFloat(counter) * gap * 3
            let edgeInsets = UIEdgeInsets(top: topInset, left: sideInset, bottom: bottomInset, right: sideInset)
//            imageView.autoPinEdgesToSuperviewEdges(with: edgeInsets)
            imageView.pinToSuperview(withEdgeInsets: edgeInsets)
			self.sendSubviewToBack(imageView)
			imageViews.append(imageView)
		}
	}
	
	func set(image: UIImage, forViewAt number: Int)
	{
		imageViews[number].image = image
	}
	
	
	convenience init(images: Array<UIImage>, viewGap: CGFloat = 3.0)
	{
		
		self.init(viewCount: images.count, viewGap: viewGap)
		for (number, image) in images.enumerated()
		{
			self.set(image: image, forViewAt: number)
		}
	}
    
    func sizeForViewAt(number: Int) -> CGSize
    {
        let edgeSize = self.bounds.width - (CGFloat(imageViews.count + 2 * number) * gap)
        return CGSize(width: edgeSize, height: edgeSize)
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
