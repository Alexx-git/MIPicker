//
//  MIPShowDemoViewController.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit
import Photos

class MIPShowDemoViewController: UIViewController, UICollectionViewDataSource, MIPDelegate, UINavigationControllerDelegate {

    var items: Array<Dictionary<UIImagePickerController.InfoKey, Any>> = []
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select Photos", style: .plain, target: self, action: #selector(didClickSelectButton(sender:)))
        
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.autoPinEdgesToSuperviewEdges()
        PhotoCollectionViewCell.register(collectionView: collectionView)
        setupFlowLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupFlowLayout()
    }
    
    func setupFlowLayout()
    {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = (collectionView.frame.width - 3 * flowLayout.minimumInteritemSpacing) / 4
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.itemSize = itemSize
    }
    
    @objc func didClickSelectButton(sender: UIBarButtonItem)
    {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    DispatchQueue.main.async {
                        self.showMIPNavController()
                    }
                }
                else {}
            })
        }
        else if photos == .authorized
        {
            showMIPNavController()
        }
        
    }
    
    func showMIPNavController()
    {
        let navController = PickerController()
        navController.delegate = self
        self.present(navController, animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MIPCollectionViewCell.dequeue(collectionView: collectionView, for: indexPath)
        let imageDictionary = items[indexPath.row]
        if let image = imageDictionary[.originalImage] as? UIImage
        {
            cell.imageView.image = image
        }
        else
        {
            print("Error - dictionary should have UIImage for the key .originalImage")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // Mark: - MIPDelegate methods
    
    func imagePickerController(_ picker: PickerController, didFinishPickingMediaWithInfo infoArray: Array<Dictionary<UIImagePickerController.InfoKey, Any>>) {
        items = infoArray
        collectionView.reloadData()
        view.layoutSubviews()
    }
}
