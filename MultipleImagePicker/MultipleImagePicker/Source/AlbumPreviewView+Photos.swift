//
//  AlbumPreviewView+Photos.swift
//  MultipleImagePicker
//
//  Created by ALEXANDER on 3/18/19.
//  Copyright © 2019 ALEXANDER. All rights reserved.
//

import UIKit
import Photos

extension AlbumPreviewView
{
    func setImagesFrom(album: PHFetchResult<PHAsset>, count: Int = 3, gap: CGFloat = 2.0, imageSize: CGSize)
	{
		let viewCount = min(album.count, count)
        var imageDictionary: Dictionary<Int, UIImage> = [:]
        var images: Array<UIImage>
        var block: Int = viewCount
        for counter in 0..<viewCount
        {
            PHImageManager.default().requestImage(for: album[counter], targetSize: imageSize, contentMode: .aspectFit, options: nil) { (image, _) -> Void in
                imageDictionary[counter] = image
                block -= 1
            }
        }
//        self.setPreviews(images: images, gap: gap)
	}
}
