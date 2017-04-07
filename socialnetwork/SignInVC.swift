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
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: FEEDVC_SEGUE, sender: nil)
        }
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
                print("USER CONNECTED AUTH FACEBOOK")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential, completion: {
                    (result) in
                    switch result {
                        case .Success(let user):
                            print("USER CONNECTED SUCCEFULLY ON FIREBASE: \(user.email)")
                            self.doOnSuccessfullyLogin(user: user)
                            break
                        case .Failure(let error):
                            print("ERROR ON CONNECT ON FIREBASE: \(error.localizedDescription)")
                    }
                })
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential, completion: @escaping (Result<FIRUser>) -> ()) {
        FIRAuth.auth()?.signIn(with: credential, completion: {
            (user, error) in
            if error != nil {
                print("UNABLE TO AUTH WITH FIREBASE - \(error)")
                completion(Result.Failure(error!))
            }
            if user != nil {
                completion(Result.Success(user!))
            } else {
                completion(Result.Failure(LoginError.userNotFound))
            }
        })
    }
    
    @IBAction func signInBtnPressed(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            firebaseAuth(FIREmailPasswordAuthProvider.credential(withEmail: email, password: password), completion: {
                (result) in
                switch result {
                case .Success(let user):
                    print("USER CONNECTED SUCCEFULLY: \(user.email)")
                    self.doOnSuccessfullyLogin(user: user)
                    break
                case .Failure(let error):
                    if case LoginError.userNotFound = error {
                        print("USER DOESN'T EXIST, CREATING IT")
                        self.createFireBaseUser(email: email, password: password)
                    } else {
                        print("ERROR ON CONNECT ON FIREBASE: \(error.localizedDescription)")
                    }
                }
            })
        }
    }
    
    func createFireBaseUser(email: String, password: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil {
                print("ERROR ON CREATE USER ON FIREBASE- \(error)")
            } else {
                if let user = user {
                    print("USER CREATED ON FIREBASE - \(user.email)")
                    self.doOnSuccessfullyLogin(user: user)
                }
            }
        })
    }
    
    func doOnSuccessfullyLogin(user: FIRUser) {
        KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
        performSegue(withIdentifier: FEEDVC_SEGUE, sender: nil)
    }
}

