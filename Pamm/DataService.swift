//
//  DataServices.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/22/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "https://brilliant-inferno-55.firebaseio.com"


class DataSerice {
    
    
    private let _REF_BASE = Firebase(url: "\(BASE_URL)")
    private let _REF_POSTS = Firebase(url: "\(BASE_URL)/posts")
    private let _REF_USERS = Firebase(url: "\(BASE_URL)/users")
    
    var REF_BASE: Firebase {
        get {
            return _REF_BASE
        }
    }
    var REF_POSTS: Firebase {
        get {
            return _REF_POSTS
        }
    }
    var REF_USERS: Firebase {
        get {
            return _REF_USERS
        }
    }
    
    
    
    func createFireBseUser(uid: String, user: Dictionary<String,String>) -> Void {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    
    
    
    
    
    
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> DataSerice {
        struct Singleton {
            static var sharedInstance = DataSerice()
        }
        return Singleton.sharedInstance
    }

    
    
}
