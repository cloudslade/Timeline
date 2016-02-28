//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Dylan Slade on 2/28/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithImageIdentifier(identifier: String) {
        ImageController.imageForIdentifier(identifier) { (image) -> Void in
            self.imageView.image = image
        }
    }
}

// One cannot assign children views as outlets if the parent cell has already been given a reuse identifier.