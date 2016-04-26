//
//  Posts.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/25/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import Foundation

class Post {
    private var _postDescription: String!
    private var _imageURL: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    
    
    var postDescription: String {
        get {
            guard let desc = _postDescription else {
                return ""
            }
            return desc
        }
    }
    
    var imageURL: String {
        get {
            return _imageURL!
        }
    }
    
    var likesCount: Int {
        get {
            return _likes
        }
    }
    
    var userName: String {
        get {
            return _username
        }
    }
    
    
    init(description: String, imageURL: String?, username: String) {
        self._postDescription = description
        self._imageURL = imageURL
        self._username = username
    }
    
    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
        
        self._postKey = postKey
        
        guard let likes = dictionary["likes"] as? Int else {
            print("Error loading likes ")
            return
        }
        
        guard let imagelink = dictionary["imageURL"] as? String else {
            print("Error loading imagelink ")
            return
        }
        
        guard let desc = dictionary["description"] as? String else {
            print("Error loading description ")
            return
        }
        
        self._likes = likes
        self._imageURL = imagelink
        self._postDescription = desc
        
        
    }
    
    enum PostCreationError: ErrorType {
        case ZeroLikes
        case NoImageURL
        case NoDescription
    }
}