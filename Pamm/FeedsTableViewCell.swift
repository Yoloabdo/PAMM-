//
//  FeedsTableViewCell.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/23/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit
import Alamofire

class FeedsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showCaseImg: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var textPostField: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var postEntity: Post! {
        didSet{
            updateUI()
        }
    }
    
    var request: Request?
    var cachedImage: UIImage?
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        
        showCaseImg.clipsToBounds = true
    }
    
    func updateUI() -> Void {
        // clearing the cell
        showCaseImg.image = nil
        
        // loading info
        textPostField.text = postEntity.postDescription
        likesNumberLabel.text = "\(postEntity.likesCount)"
        
        // checking if the image is cached, if not make a new request and get it.
        if let link = postEntity.imageURL {
            if (imageCache[link] != nil) {
                showCaseImg.image = imageCache[link] as? UIImage
            }else{
                request = Alamofire.request(.GET, link).validate(contentType: ["image/*"]).response{
                    (request, response, data, error) in
                    guard let data = data else {
                        print(error?.description)
                        return
                    }
                    
                    guard let img = UIImage(data: data) else {
                        print("Couldn't interpret data to image")
                        return
                    }
                    
                    self.showCaseImg.image = img
                    imageCache[link] = img
                }
            }
        }else {
            showCaseImg?.hidden = true
        }
    }

}

extension NSCache {
    subscript(key: AnyObject) -> AnyObject? {
        get {
            return objectForKey(key)
        }
        set {
            if let value: AnyObject = newValue {
                setObject(value, forKey: key)
            } else {
                removeObjectForKey(key)
            }
        }
    }
}
