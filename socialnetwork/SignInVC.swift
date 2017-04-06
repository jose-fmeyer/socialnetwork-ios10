//
//  ViewController.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 05/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func facebookLoginPressed(_ sender: UIButton) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            if error != nil {
                print("USER UNENABLED ON FACEBOOK - \(error)")
            } else if result?.isCancelled == true {
                print("USER CANCELED AUTH")
            } else {
                print("USER CONNECTED AUTH")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: {
            (user, error) in
            if error != nil {
                print("UNABLE TO AUTH WITH FIREBASE - \(error)")
            } else {
                print("CONNECTED WITH FIREBASE")
            }
        })
    }
}

