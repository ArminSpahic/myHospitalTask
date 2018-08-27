//
//  DoctorCustomCellTableViewCell.swift
//  Task
//
//  Created by Armin Spahic on 15/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit

class DoctorCustomCell: UITableViewCell {

    @IBOutlet weak var doctorPosition: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
