//
//  DoctorTableHeader.swift
//  Task
//
//  Created by Armin Spahic on 8/24/18.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation
import UIKit

protocol DoctorHeaderDelegate : class{
    func didTapDismissInHeader()
    func didTapViewChecklistInHeader()
}

class DoctorTableHeader : UIView {
    
    @IBOutlet weak var borderImageView: UIImageView!
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorType: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    
    weak var delegate : DoctorHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doctorImage.layer.cornerRadius = doctorImage.frame.size.width / 2
        doctorImage.layer.masksToBounds = true
        doctorImage.layer.borderColor = UIColor.lightGray.cgColor
        doctorImage.layer.borderWidth = 0.5;
        self.clipsToBounds = true;
    }
    
    
    @IBAction func dismissAction(_ sender: Any) {
        delegate?.didTapDismissInHeader()
    }
    
    @IBAction func viewChecklistAction(_ sender: Any) {
        delegate?.didTapViewChecklistInHeader()
    }
}
