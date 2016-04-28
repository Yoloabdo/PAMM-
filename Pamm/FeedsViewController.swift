//
//  FeedsViewController.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/23/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newPostTextField: MaterialTextField!
    
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
    @IBOutlet weak var imagePickerView: UIImageView!
    
    var imagePicker: UIImagePickerController!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         watchData()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
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
        // canceling the old request
        cell.request?.cancel()
        // passing the new cell info
        cell.postEntity = posts[indexPath.row]
        
        return cell
    }
    
    /*
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if posts[indexPath.row].imageURL != nil {
            return tableView.estimatedRowHeight
        }else {
            return 130
        }
    }
 
 */
    
    // post stuff
    var imageSelcted: UIImage!

}

extension FeedsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBAction func imagePicker(sender: UITapGestureRecognizer) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func makePost(sender: MaterialButton) {
        
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .White)
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.center = imagePickerView.center
        
        
        
        
        if let text = newPostTextField.text where text != "" {
            if let image = imageSelcted {
                let urlStr = "https://api.imageshack.com/v2/images"
                let url = NSURL(string: urlStr)
                let jpegIm = UIImageJPEGRepresentation(image, 0.2)!
                let key = "LXMS71Z37f6056d4bc7ef298a0ab07389ad85369".dataUsingEncoding(NSUTF8StringEncoding)
                let keyJson = "json".dataUsingEncoding(NSUTF8StringEncoding)
                imagePickerView.addSubview(activity)
                Alamofire.upload(.POST, url!, multipartFormData: { (MultipartFormData) in
                    MultipartFormData.appendBodyPart(data: jpegIm, name: "fileupload", fileName: "iamge", mimeType: "image/jpg")
                    MultipartFormData.appendBodyPart(data: key!, name: "key")
                    MultipartFormData.appendBodyPart(data: keyJson!, name: "format")
                    
                    }, encodingCompletion: { (results) in
                        switch results {
                        case .Success(let upload , _, _):
                            upload.responseJSON(completionHandler: { (response) in
                                
                                if let error = response.result.error {
                                    print(error)
                                    return
                                } else {
                                    
                                    var json: Dictionary<String, AnyObject>!
                                    do {
                                        json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments) as! Dictionary<String, AnyObject>
                                    } catch {
                                        print("couldn't parse data")
                                        return
                                    }
                                 
                                    guard let result = json["result"], let images = result["images"] else {
                                        print("couldn't find links in results")
                                        return
                                    }
                                    
                                    guard let imgArr = images![0], let imageLink = imgArr["direct_link"] as? String else {
                                        print("Couldn't find image")
                                        return
                                    }
                                    self.postToFireBase(imageLink, activity: activity)
                                }
                                
                            })
                        case .Failure(let error):
                            print(error)
                        }
                        
                })
                
                
                
            }
        }
    }
    
    func postToFireBase(imageUrl: String, activity: UIActivityIndicatorView) {
        let post: Dictionary<String, AnyObject> = [
        "describtion": newPostTextField.text!,
        "likes": Int(0),
        "imageURL": imageUrl
        ]
        let firebasePost = DataService.sharedInstance().REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        newPostTextField.text = ""
        imageSelcted = nil
        activity.stopAnimating()
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageSelcted = image
    }
    
}
