//
//  ChatViewController.swift
//  LetsTalkAboutParsely
//
//  Created by Patrick Stein on 9/9/15.
//  Copyright (c) 2015 Patrick Stein. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var navBar: UINavigationBar!
    let textField = UITextField()
    var user: PFUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.placeholder = "Type a message"
        textField.returnKeyType = UIReturnKeyType.Send
        textField.delegate = self
        navBar.topItem?.titleView = textField
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendMessage(textField)
        return true
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        NSLog(textField.text)
        
        let message = PFObject(className: "Message")
        message["text"] = "Hai guyz"
        message.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                NSLog("Sent message")
            }
        }
    }
}
