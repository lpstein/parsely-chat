//
//  MessageTableViewCell.swift
//  LetsTalkAboutParsely
//
//  Created by Patrick Stein on 9/9/15.
//  Copyright (c) 2015 Patrick Stein. All rights reserved.
//

import UIKit
import Parse

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: PFObject! {
        didSet {
            if let text = message["text"] as? String {
                messageLabel.text = text
            }
            if let user = message["user"] as? PFUser {
                usernameLabel.text = user.username
            } else {
                usernameLabel.text = "Unknown"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
