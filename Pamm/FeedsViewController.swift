//
//  FeedsViewController.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/23/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit
import Firebase

class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var feedsTableView: UITableView! {
        didSet{
            feedsTableView.delegate = self
            feedsTableView.dataSource = self
        }
    }
    
    var posts = [Post]() {
        didSet{
            self.feedsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
     watchData()
    }
    
    func watchData() -> Void {
        DataService.sharedInstance().REF_POSTS.observeEventType(.Value, withBlock: { (snapShot) in
            
            self.posts = []
            guard let snapShots = snapShot.children.allObjects as? [FDataSnapshot] else {
                "Couldn't parse data from firebase"
                return
            }
            
            for snap in snapShots {
                guard let postDict = snap.value as? Dictionary<String, AnyObject> else {
                    print("wrong parsing snap value")
                    return
                }
                
                let key = snap.key
                let post = Post(postKey: key, dictionary: postDict)
                self.posts.append(post)
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    struct StoryBoard {
        static let CellIDentfier = "feedsCell"
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.CellIDentfier) as! FeedsTableViewCell
        let post = posts[indexPath.row]
        print(post.postDescription)
        return cell
    }
}
