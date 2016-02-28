//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    var user: User?
    var userPosts: [Post] = []
    
    override func viewDidLoad() {
        print(user?.userName)
    }
    
    func updateBasedOnUser(user: User) {
        
    }
}