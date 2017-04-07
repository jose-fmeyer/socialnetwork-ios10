//
//  PostCell.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 07/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: FancyView!

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var likeImage: CircleView!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postText: UITextView!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareUI() {
        
    }
}
