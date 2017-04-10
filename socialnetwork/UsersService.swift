//
//  UsersService.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 10/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import Foundation

class UsersService {
    
    public class var instance: UsersService {
        struct Singleton {
            static let instance: UsersService = UsersService()
        }
        return Singleton.instance
    }
    
    private init() {}
    
    func createUser(uid: String, userData: Dictionary<String, String>) {
        DataService.instance.REF_USERS.child(uid).updateChildValues(userData)
    }
}
