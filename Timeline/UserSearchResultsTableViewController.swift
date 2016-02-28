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
}