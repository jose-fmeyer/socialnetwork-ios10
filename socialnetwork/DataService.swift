//
//  DataService.swift
//  socialnetwork
//
//  Created by Jose Fernando Meyer on 10/04/17.
//  Copyright © 2017 Jose Fernando Meyer. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    public class var instance: DataService {
        struct Singleton {
            static let instance: DataService = DataService()
        }
        return Singleton.instance
    }
    
    private init() {}
    
    private var _REF_BASE = DB_BASE
    
    private var _REF_POSTS = DB_BASE.child("posts")
    
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REAF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
}
