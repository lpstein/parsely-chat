//
//  ChatViewController.swift
//  LetsTalkAboutParsely
//
//  Created by Patrick Stein on 9/9/15.
//  Copyright (c) 2015 Patrick Stein. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    let textField = UITextField()
    var user: PFUser!
    var messages: [PFObject] = []
    var timer: NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.placeholder = "Type a message"
        textField.returnKeyType = UIReturnKeyType.Send
        textField.delegate = self
        
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTimer() {
        NSLog("Timer")
        
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            if let error = error {
                NSLog(error.description)
                return
            }
            
            self.messages = objects as! [PFObject]
            self.tableView.reloadData()
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendMessage(textField)
        return true
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        let message = PFObject(className: "Message")
        message["user"] = user
        message["text"] = "Hai guyz"
        message.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                NSLog("Sent message")
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.shazam.MessageTableViewCell", forIndexPath: indexPath) as! MessageTableViewCell
        cell.message = messages[indexPath.row]
        return cell
    }
}
