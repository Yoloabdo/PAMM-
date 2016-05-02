//
//  TimeTableViewCell.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 5/1/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var SubjectTitleLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLable: UILabel!
    @IBOutlet weak var loactionLabel: UILabel!
    @IBOutlet weak var LecturerImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
