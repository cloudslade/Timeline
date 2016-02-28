//
//  LoginSignUpChoiceViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class LoginSignUpChoiceViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSignup" {
            let ourLoginChoiceViewController = segue.destinationViewController as! LoginSignUpViewController
            ourLoginChoiceViewController.mode = .Signup
        } else {
            let ourLoginChoiceViewController = segue.destinationViewController as! LoginSignUpViewController
            ourLoginChoiceViewController.mode = .Login
        }
    }
}