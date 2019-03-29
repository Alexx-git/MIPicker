//
//  PickerController.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit

class PickerController: UIViewController {
	
	let albumController = AlbumListViewController()
	var navController: UINavigationController?
	
	weak open var delegate: (UINavigationControllerDelegate & MIPDelegate)?
	{
		didSet
		{
			albumController.picker = self
			if navController != nil
			{
				navController!.delegate = delegate
			}
		}
	}

    
    public var userAlbumsTitle: String? = "My Albums"
    {
        didSet
        {
            albumController.userAlbumsTitle = userAlbumsTitle
        }
    }
	
	public var imagePickingFinishedButtonTitle: String? = "Done"
	{
		didSet
		{
			albumController.imagePickingFinishedButtonTitle = imagePickingFinishedButtonTitle
		}
	}
	
	
	init()
	{
		navController = UINavigationController(rootViewController: albumController)
		super.init(nibName: nil, bundle: nil)
		
		self.addChild(navController!)
		self.view.addSubview(navController!.view)
//        navController!.view.autoPinEdgesToSuperviewEdges()
        navController!.view.pinToSuperview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}

protocol MIPDelegate: class {
    func imagePickerController(_ picker: PickerController,
                               didFinishPickingMediaWithInfo infoArray: Array<Dictionary<UIImagePickerController.InfoKey, Any>>)
    
    
    func imagePickerControllerDidCancel(_ picker: PickerController)
}
