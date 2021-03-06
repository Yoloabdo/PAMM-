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


class DataService {
    
    
    private let _REF_BASE = Firebase(url: "\(BASE_URL)")
    private let _REF_POSTS = Firebase(url: "\(BASE_URL)/posts")
    private let _REF_USERS = Firebase(url: "\(BASE_URL)/users")
    
//    private let _REF_TABLE = Firebase(url: "\(BASE_URL)/college-table")
    
    private let _THIRD_YEAR = Firebase(url: "\(BASE_URL)/college-table/computer-science/third-year/cs-dep/sec-4")
    
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
    
    var REF_TABLE_THIRD_SEC4: Firebase {
        get{
            return _THIRD_YEAR
        }
    }
    
    
    
    func createFireBseUser(uid: String, user: Dictionary<String,String>) -> Void {
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    
    
    
    
    
    
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> DataService {
        struct Singleton {
            static var sharedInstance = DataService()
        }
        return Singleton.sharedInstance
    }

    
    
}
