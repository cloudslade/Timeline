//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class TimelineTableViewController: UITableViewController {
    var posts: [Post] = []
    
    @IBAction func refreshPulled(sender: UIRefreshControl) {
        loadTimelineForUser(UserController.sharedUserController.currentUser)
    }

    override func viewDidLoad() {
        loadTimelineForUser(UserController.sharedUserController.currentUser)
    }
    
    override func viewWillAppear(animated: Bool) {
        guard let currentUser = UserController.sharedUserController.currentUser else {
            tabBarController?.performSegueWithIdentifier("toLoginOrSignup", sender: nil)
            return
        }
        if posts.count > 0 {
            //Here we would load the timeline
        }
        // Here we would do nothing since we don't need to load any views because the user does not have any posts
    }
    
    func loadTimelineForUser(user: User) {
        PostController.fetchTimeLineForUser(user) { (posts) -> Void in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timelineCell", forIndexPath: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.updateWithPost(post)
        return cell
    }
    
}