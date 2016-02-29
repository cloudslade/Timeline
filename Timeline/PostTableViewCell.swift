//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Dylan Slade on 2/28/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    func updateWithPost(post: Post) {
        ImageController.imageForIdentifier(post.imageEndPoint, completion: { (image) -> Void in
            if let image = image {
                self.postImageView.image = image
            }
        })
        likesLabel.text = "Likes: \(post.likes.count)"
        commentsLabel.text = "Comments: \(post.comments.count)"
    }
}
