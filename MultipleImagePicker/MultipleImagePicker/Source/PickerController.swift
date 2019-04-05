//
//  PickerController.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit

public class PickerController: UIViewController {
	
	let albumController = AlbumListViewController()
	var navController: UINavigationController?
	
    weak public var delegate: (UINavigationControllerDelegate & MIPickerDelegate)? {
		didSet {
			if navController != nil {
				navController!.delegate = delegate
			}
		}
	}
    
    public var albumControllerTitle: String? = "Photos" {
        didSet {
            albumController.albumControllerTitle = albumControllerTitle
        }
    }

    public var userAlbumsTitle: String? = "My Albums" {
        didSet {
            albumController.userAlbumsTitle = userAlbumsTitle
        }
    }
	
	public var doneButtonTitle: String? = "Done" {
		didSet {
			albumController.doneButtonTitle = doneButtonTitle
		}
	}
	
	init() {
        super.init(nibName: nil, bundle: nil)
        albumController.picker = self
		navController = UINavigationController(rootViewController: albumController)
		self.addChild(navController!)
		self.view.addSubview(navController!.view)
        navController!.view.pinToSuperview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

public protocol MIPickerDelegate: class {
    
    @available(iOS 12.0, *)
    func imagePickerController(_ picker: PickerController,
                               didFinishPickingMediaWithInfo infoArray: Array<Dictionary<UIImagePickerController.InfoKey, Any>>)
    
    @available(iOS, deprecated: 12.0)
    func imagePickerController(_ picker: PickerController,
                               didFinishPickingMediaWithInfo infoArray: Array<Dictionary<String, Any>>)
    
    func imagePickerControllerDidCancel(_ picker: PickerController)
}
