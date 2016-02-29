//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource, ProfileHeaderCollectionReusableViewDelegate {
    var user: User?
    var userPosts: [Post] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        print(user?.userName)
        if self.user == nil {
            self.user = UserController.sharedUserController.currentUser
            editBarButtonItem.enabled = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        //        UserController.userForIdentifier(user!.identifier!) { (user) -> Void in
        //            self.user = user
        //            self.updateBasedOnUser()
        //        }
    }
    
    func updateBasedOnUser() {
        if let user = user {
            self.title = user.userName
            PostController.postsForUser(user) { (posts) -> Void in
                if let posts = posts {
                    self.userPosts = posts
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.collectionView.reloadData()
                })
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let post = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.updateWithImageIdentifier(post.imageEndPoint)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! ProfileHeaderCollectionResuableView// WTF is going on in this line.
        headerView.updateWithUser(user!)
        headerView.delegateVariable = self
        return headerView
    }
    
    func userTappedURLButton() {
        if let profileUrl = NSURL(string: user!.URL!) {
            let safariViewController = SFSafariViewController(URL: profileUrl)
            presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        if user == UserController.sharedUserController.currentUser {
            UserController.logoutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
        } else {
            UserController.userFollowsUser(UserController.sharedUserController.currentUser, user2: user, completion: { (follows) -> Void in
                if follows {
                    UserController.unfollowUser(self.user!, completion: { (success) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                } else {
                    UserController.followUser(self.user!, completion: { (success) -> Void in
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toEditProfile" {
            let destinationViewController = segue.destinationViewController as! LoginSignUpViewController
            destinationViewController.updateWithUser(user!)
        }
    }
    
}








