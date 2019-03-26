//
//  PhotoCollectionViewCell.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

	let checkmarkImageView = UIImageView(image: UIImage(named: "icons8-ok"))
	let durationLabel = UILabel()
	
	var imageView = UIImageView()
	
	let checkmarkSize = CGSize(width: 24.0, height: 24.0)
	let checkmarkInset: CGFloat = 10.0
	
	class func classReuseIdentifier() -> String {
		return  String(describing:self)
	}
	
	class func register(collectionView:UICollectionView) {
		collectionView.register(self.classForCoder(), forCellWithReuseIdentifier: classReuseIdentifier())
	}
	
	class func dequeue(collectionView:UICollectionView, for indexPath: IndexPath) -> Self {
		func helper<T>(collectionView:UICollectionView) -> T where T : MIPCollectionViewCell {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: classReuseIdentifier(), for: indexPath) as! PhotoCollectionViewCell
			return cell as! T
		}
		return helper(collectionView:collectionView)
	}
	
	func setSelected()
	{
//		blurLabel.isHidden = false
		checkmarkImageView.isHidden = false
	}
	
	func setDeselected()
	{
//		blurLabel.isHidden = true
		checkmarkImageView.isHidden = true
	}
	
	override func prepareForReuse() {
		setDeselected()
		durationLabel.isHidden = true
	}
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentView.addSubview(imageView)
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
		imageView.autoPinEdgesToSuperviewEdges()
        
		contentView.addSubview(checkmarkImageView)
		checkmarkImageView.autoSetDimensions(to: checkmarkSize)
		checkmarkImageView.autoPinEdge(toSuperviewEdge: .right, withInset: checkmarkInset)
		checkmarkImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: checkmarkInset)
		checkmarkImageView.isHidden = true
		
		contentView.addSubview(durationLabel)
		durationLabel.backgroundColor = .clear
		durationLabel.textAlignment = .center
		durationLabel.autoPinEdgesToSuperviewEdges()
		durationLabel.isHidden = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}
