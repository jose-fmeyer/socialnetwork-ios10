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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtnPressed(_ sender: UIButton) {
        if KeychainWrapper.standard.removeObject(forKey: KEY_UID) {
            try! FIRAuth.auth()?.signOut()
            dismiss(animated: true, completion: nil)
        }
    }
}
