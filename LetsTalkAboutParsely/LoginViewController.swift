//
//  LoginViewController.swift
//  LetsTalkAboutParsely
//
//  Created by Patrick Stein on 9/9/15.
//  Copyright (c) 2015 Patrick Stein. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    var user: PFUser? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInTapped(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(emailField.text, password: passwordField.text) { (user, error) -> Void in
            if let error = error {
                UIAlertView(title: "Login Error", message: error.description, delegate: nil, cancelButtonTitle: "Damn").show()
                return
            }
            if let user = user {
                self.user = user
                self.performSegueWithIdentifier("launch", sender: self)
            }
        }
    
    }
    
    @IBAction func signUpTapped(sender: AnyObject) {
        let user = PFUser()
        user.email = emailField.text
        user.password = passwordField.text
        user.username = user.email
        
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if let error = error {
                UIAlertView(title: "Signup Error", message: error.description, delegate: nil, cancelButtonTitle: "Damn").show()
                return
            }
            if success {
                self.user = user
                self.performSegueWithIdentifier("launch", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? ChatViewController {
            controller.user = self.user
        }
    }
}
