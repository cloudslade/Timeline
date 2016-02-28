//
//  ProfileHeaderCollectionResuableView.swift
//  Timeline
//
//  Created by Dylan Slade on 2/28/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ProfileHeaderCollectionResuableView: UICollectionReusableView {
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    var delegateVariable: ProfileHeaderCollectionReusableViewDelegate?
    
    func updateWithUser(user: User) {
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.hidden = true
        }
        if let url = user.URL {
            homepageButton.setTitle(url, forState: UIControlState.Normal)
        } else {
            homepageButton.hidden = true
        }
        
        if user == UserController.sharedUserController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
        } else {
            UserController.userFollowsUser(UserController.sharedUserController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
    
    @IBAction func urlButtonTapped() {
        delegateVariable?.userTappedURLButton()
    }
    
    @IBAction func followActionButtonTapped() {
        delegateVariable?.userTappedFollowActionButton()
    }
    
}

protocol ProfileHeaderCollectionReusableViewDelegate {
    func userTappedFollowActionButton()
    func userTappedURLButton()
}

// I need to learn more about the delegate as a variable. I didnt know you could store a protocol in a variable or that you could store a protocol in a variable. I am confused now.