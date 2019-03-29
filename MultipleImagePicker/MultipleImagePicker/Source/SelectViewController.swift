//
//  SelectViewController.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import Foundation
import UIKit
import Photos
import MobileCoreServices


class SelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
	
	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	
	var items: PHFetchResult<PHAsset>!
	var selectedImagesIndexPaths: Array<IndexPath> = []
	
	
	var picker: PickerController?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didClickDoneButton(sender:)))
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.allowsSelection = true
		collectionView.allowsMultipleSelection = true
		collectionView.backgroundColor = .white
		let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		flowLayout.minimumInteritemSpacing = 5.0
		flowLayout.minimumLineSpacing = 5.0
		setupFlowLayout()
		PhotoCollectionViewCell.register(collectionView: collectionView)
		view.addSubview(collectionView)
//        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.pinToSuperview()
	}
	
	override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
		setupFlowLayout()
	}
	
	func setupFlowLayout()
	{
		let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		let itemWidth = (collectionView.frame.width - 3 * flowLayout.minimumInteritemSpacing) / 4
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
	}
	
	
	
	
	// MARK: - UICollectionViewDataSource methods
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = PhotoCollectionViewCell.dequeue(collectionView: collectionView, for: indexPath)
		let asset = items[indexPath.row]
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		PHImageManager.default().requestImage(for: asset, targetSize: flowLayout.itemSize, contentMode: .aspectFit, options: nil) { (image, _) -> Void in
			cell.imageView.image = image
			cell.contentView.backgroundColor = .red
		}
		if selectedImagesIndexPaths.contains(indexPath)
		{
			cell.setSelected()
		}
		if asset.mediaType == .video
		{
			cell.durationLabel.isHidden = false
			let duration = asset.duration
			let seconds = trunc(duration.truncatingRemainder(dividingBy: 60.0))
			let minutes = trunc((duration / 60.0).truncatingRemainder(dividingBy: 60.0))
			let hours = trunc(duration / 3600)
			if hours > 0
			{
				cell.durationLabel.text = String(format: "%02.0f:%02.0f:%02.0f", hours, minutes, seconds)
			}
			else
			{
				cell.durationLabel.text = String(format: "%02.0f:%02.0f", minutes, seconds)
			}
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedImagesIndexPaths.append(indexPath)
		let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
		cell.setSelected()
	}
	
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		if let indexOfPath = selectedImagesIndexPaths.index(of: indexPath)
		{
			selectedImagesIndexPaths.remove(at: indexOfPath)
		}
		let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
		cell.setDeselected()
	}
	
	
	
	
	@objc func didClickDoneButton(sender: UIBarButtonItem)
	{
        var imageDictionaries: Array<Dictionary<UIImagePickerController.InfoKey, Any>> = []
		var counter = selectedImagesIndexPaths.count
		for path in selectedImagesIndexPaths
		{
            var mediaDictionary: Dictionary<UIImagePickerController.InfoKey, Any> = [:]
			let asset = items[path.row]
            if asset.mediaType == .video
            {
                mediaDictionary[.mediaType] = kUTTypeVideo
            }
            else
            {
                mediaDictionary[.mediaType] = kUTTypeImage
            }
			
			let name = asset.value(forKey: "filename") as? String
            
			PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (image, _) -> Void in
                mediaDictionary[.originalImage] = image
                imageDictionaries.append(mediaDictionary)
				counter -= 1
				if counter == 0
				{
                    if self.picker != nil
                    {
                        self.picker!.delegate?.imagePickerController(self.picker!, didFinishPickingMediaWithInfo: imageDictionaries)
                        self.navigationController?.parent?.dismiss(animated: true, completion: nil)
                    }
                    
				}
			}
		}
	}

}


