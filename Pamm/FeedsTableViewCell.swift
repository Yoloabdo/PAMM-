//
//  FeedsTableViewCell.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/23/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit

class FeedsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var showCaseImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func drawRect(rect: CGRect) {
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        profileImg.clipsToBounds = true
        
        showCaseImg.clipsToBounds = true
    }

}
