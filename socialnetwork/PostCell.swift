//
//  PostCell.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 07/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import UIKit
import FirebaseStorage

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: FancyView!

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var likeImage: CircleView!
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var postText: UITextView!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareUI(post: Post, img: UIImage?) {
        self.post = post
        postText.text = post.caption
        likeCountLabel.text = "\(post.likes)"
        
        if img != nil {
            postImage.image = img
        } else {
            downloadPostImage(imageUrl: post.imageUrl)
        }
    }
    
    private func downloadPostImage(imageUrl: String) {
        PostService.instance.downloadPostImageFromStorage(imageUrl: imageUrl) { (result) in
            switch result {
            case .Success(let data):
                self.setImageData(data: data)
                break
            case .Failure(let error):
              if let resourceNotFoundError = error as? DownloadError {
                  print(resourceNotFoundError.description())
              } else {
                  print("ERROR ON DOWNLOAD IMAGE FROM STORAGE: \(error.localizedDescription)")
              }
            }
        }
    }
    
    private func setImageData(data: Data?) {
        if let imageData = data {
            if let img = UIImage(data: imageData) {
                self.postImage.image = img
                FeedVC.imageCache.setObject(img, forKey: NSString(string: post.imageUrl))
            }
        }
    }
}
