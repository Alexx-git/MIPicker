//
//  CP3AlbumTypeViewController.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import Foundation
import UIKit
import Photos

class MIPAlbumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	let tableView = UITableView.newAutoLayout()
	
	
	var items: Array<Array<PHFetchResult<PHAsset>>> = []
	var names: Array<Array<String>> = []
	
	var imagePickingFinishedButtonTitle: String?

	
	let imageSize = CGSize(width: 100.0, height: 100.0)
	
	let headerReuseIdentifier = String(describing: UITableViewHeaderFooterView.self)
	
	var picker: MIPickerController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Photos"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(didClickCloseButton(sender:)))
		view.addSubview(tableView)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.autoPinEdgesToSuperviewEdges()
		tableView.tableFooterView = UIView()
		MIPTableViewCell.register(tableView: tableView)
		tableView.register(UITableViewHeaderFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: headerReuseIdentifier)
		loadItems()
	}

	
	
	func loadItems()
	{
		let sortByCreationDateOptions = PHFetchOptions()
		sortByCreationDateOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
		
		let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
		var assetsArray: Array<PHFetchResult<PHAsset>> = []
		var namesArray: Array<String> = []
		for counter in 0..<smartAlbums.count
		{
			let collection = smartAlbums[counter]
			let assets = PHAsset.fetchAssets(in: collection, options: sortByCreationDateOptions)
			if assets.count > 0
			{
				if let title = collection.localizedTitle
				{
					namesArray.append(title)
				}
				else
				{
					namesArray.append("Unnamed album")
				}
				
				assetsArray.append(assets)
			}
		}
		items.append(assetsArray)
		names.append(namesArray)
		assetsArray = []
		namesArray = []

		let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
		let count = userCollections.count
		
		for number in 0..<count
		{
			let collection = userCollections[number]
			if collection.canContainAssets
			{
				let assetCollection = collection as! PHAssetCollection
				let assets = PHAsset.fetchAssets(in: assetCollection, options: sortByCreationDateOptions)
				if assets.count > 0
				{
					if let title = collection.localizedTitle
					{
						namesArray.append(title)
					}
					else
					{
						namesArray.append("Unnamed album")
					}
					assetsArray.append(assets)
				}
			}
		}
		items.append(assetsArray)
		names.append(namesArray)
	}
    

	// MARK: - UITableViewDataSource methods
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items[section].count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = MIPTableViewCell.dequeue(tableView: tableView)
		let row = indexPath.row
		let section = indexPath.section
		cell.titleLabel.text = names[section][row]
		let assets = items[section][row]
		cell.countLabel.text = String(assets.count)
		let viewCount = min(assets.count, 3)
		for counter in 0..<viewCount
		{
			PHImageManager.default().requestImage(for: assets[counter], targetSize: imageSize, contentMode: .aspectFill, options: nil) { (image, _) -> Void in
				if image != nil
				{
					cell.previewView.set(image: image!, forViewAt: counter)
				}
			}
		}
		cell.accessoryType = .disclosureIndicator
		return cell
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 1 && items[section].count > 0
		{
			return "My Albums"
		}
		return nil
	}
	
    // MARK: UITableViewDelegate methods
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		let selectController = MIPSelectViewController()
		let row = indexPath.row
		let section = indexPath.section
		selectController.items = items[section][row]
        selectController.title = names[section][row]
		if imagePickingFinishedButtonTitle != nil
		{
			selectController.navigationItem.rightBarButtonItem?.title = imagePickingFinishedButtonTitle
		}
		selectController.picker = picker
		selectController.imageSize = imageSize
		self.navigationController?.pushViewController(selectController, animated: true)
	}
    
    // MARK: Buttons
	
	@objc func didClickCloseButton(sender: UIBarButtonItem)
	{
		self.navigationController?.parent?.dismiss(animated: true, completion: nil)
	}

}
