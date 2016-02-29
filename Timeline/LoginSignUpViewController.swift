//
//  LoginSignUpViewController.swift
//  Timeline
//
//  Created by Dylan Slade on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit

class LoginSignUpViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var websiteURLTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    var user: User?
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login:
                return !(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Signup:
                return !(userNameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Edit:
                return !(userNameTextField.text!.isEmpty)
            }
        }
    }
    var mode: ViewMode = .Signup
    
    enum ViewMode: Int {
        case Login
        case Signup
        case Edit
    }
    
    @IBAction func actionButtonTapped(sender: UIButton) {
        if fieldsAreValid {
            switch mode {
            case .Signup:
                UserController.createUser(emailTextField.text!, userName: userNameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text, url: websiteURLTextField.text, completion: { (success, user) -> Void in
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentAlertAfterFailedAuthentication("Failed to signup, Check fields and try again", message: "Yo go gurl")
                    }
                })
                return
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success) -> Void in
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentAlertAfterFailedAuthentication("Yooogz", message: "yola")
                    }
                })
                return
            case .Edit:
                UserController.updateUser(self.user!, userName: self.userNameTextField.text!, password: self.passwordTextField.text!, bio: self.bioTextField.text, url: self.websiteURLTextField.text, completion: { (success, user) -> Void in
                    if success {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentAlertAfterFailedAuthentication("Unable to update User", message: "Please try again another time.")
                    }
                })
            }
        } else {
            presentAlertAfterFailedAuthentication("Missing Information", message: "Please check your input and try again")
        }
    }
    
    func presentAlertAfterFailedAuthentication(alertTitle: String, message: String) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction1 = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(alertAction1)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func updateViewBasedOnMode() {
        switch mode {
        case .Login:
            bioTextField.hidden = true
            websiteURLTextField.hidden = true
            actionButton.setTitle("Login", forState: UIControlState.Normal)
        case .Signup:
            actionButton.setTitle("Signup", forState: UIControlState.Normal)
        case .Edit:
            actionButton.setTitle("Update", forState: .Normal)
        }
    }
    
    override func viewDidLoad() {
        updateViewBasedOnMode()
    }
    
    func updateWithUser(user: User) {
        self.user = user
        mode = .Edit
    }
    
}






