//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class UserSearchTableViewController: UITableViewController, UISearchResultsUpdating {
     // MARK: - Properties
    var usersDataSource: [User] = []
    @IBOutlet weak var friendSegmentedControl: UISegmentedControl!
    var searchController: UISearchController!
    var mode: ViewMode {
        get {
            return ViewMode(rawValue: friendSegmentedControl.selectedSegmentIndex)!
        }
    }
    
    // MARK: - Enumeration
    enum ViewMode: Int {
        case Friends
        case AllUsers
        
        func users(completion: (users: [User]?) -> Void) {
            switch self {
            case .Friends:
                UserController.followByUser(UserController.sharedUserController.currentUser, completion: { (followers) -> Void in
                    completion(users: followers)
                })
            case.AllUsers:
                UserController.fetchAllUsers({ (users) -> Void in
                    completion(users: users)
                })
            }
        }
    }
    
    // MARK - Override Functions
    override func viewDidLoad() {
        updateViewBasedOnMode()
        setUpSearchController()
    }
    
    // MARK: - Actions
    @IBAction func selectedIndexChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode()
    }
    
    // MARK: - Methods
    func updateViewBasedOnMode() {
        mode.users { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Search Controller
    // There is only one required function contained within the UISearchResultsUpdating protocol. In fact there is only one function in the entire protocol which is that required one I aforementioned.
    // This function is called updateSearchResultsForSearchController(searchController: UISearchController). It is from the UISearchResultsUpdating protocol.
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // Retreive and store the text from the search Bar.
        let searchTerm = searchController.searchBar.text?.lowercaseString ?? ""
            // My questiosn about that is where in the world do we find the searchBar?
                // The answer is that it is on the searchController. The one we declared inside our class and setup in our setUpSearchController.
        // assign the property that holds your users to a filtered array of [User] where the username contains the search term.
        let resultsViewController = searchController.searchResultsController as! UserSearchResultsTableViewController
        resultsViewController.userResultsDataSource = usersDataSource.filter {$0.userName.lowercaseString.containsString(searchTerm) }
        resultsViewController.tableView.reloadData()
        
    }
    
    func setUpSearchController() {
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("UserSearchResultsTableViewController")
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
    }
    
    // MARK: - DataSource Methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) // You must remember to call the proper dequeueRe.. function, the one that includes an indexPath.
        let user = usersDataSource[indexPath.row]
        cell.textLabel?.text = user.userName
        return cell
    }
}

















