//
//  DataServices.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/22/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import Foundation
import Firebase


class DataSerice {
    
    private let _REF_BASE = Firebase(url: "https://brilliant-inferno-55.firebaseio.com")
    
    var REF_BASE: Firebase {
        get {
            return _REF_BASE
        }
    }
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> DataSerice {
        struct Singleton {
            static var sharedInstance = DataSerice()
        }
        return Singleton.sharedInstance
    }

    
    
}
