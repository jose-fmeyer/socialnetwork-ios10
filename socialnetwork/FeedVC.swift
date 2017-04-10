//
//  FeedVCViewController.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 07/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()

    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var imageAddPicture: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        addPostObserver()
    }
    
    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        if KeychainWrapper.standard.removeObject(forKey: KEY_UID) {
            try! FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func addPostObserver() {
        DataService.instance.REAF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshotData = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshotData {
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postId: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.postsTableView.reloadData()
        })
    }
    
    @IBAction func addNewImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let postCell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            let postData = posts[indexPath.row]
            preparePostCell(post: postData, cell: postCell)
            return postCell
        }
        return UITableViewCell()
    }
    
    private func preparePostCell(post: Post, cell: PostCell) {
        if let uiImage = FeedVC.imageCache.object(forKey: NSString(string: post.imageUrl)) {
            cell.prepareUI(post: post, img: uiImage as UIImage)
        } else {
            cell.prepareUI(post: post, img: nil)
        }
    }
}

extension FeedVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAddPicture.image = image
        } else {
            print("A valid image wasn't selected!")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
