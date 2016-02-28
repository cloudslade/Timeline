//
//  UserSearchResultsTableViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class UserSearchResultsTableViewController: UITableViewController {
    // MARK: - Properties
    var userResultsDataSource: [User] = []
    
    // MARK: - Data Source Methods
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userResultsCell", forIndexPath: indexPath)
        let user = userResultsDataSource[indexPath.row]
        cell.textLabel?.text = user.userName
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResultsDataSource.count
    }
    
    // We must add a prepare for segue function that will take us from the searchResultsTableViewController to the ProfileViewController. This is because the ViewController changes when we start using search and we must therefore eaccount for the new viewCointroller.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        self.presentingViewController?.performSegueWithIdentifier("toProfileView", sender: cell)
    }
}