//
//  MyClinicCell.swift
//  Task
//
//  Created by Armin Spahic on 18/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit

class MyClinicCell: UITableViewCell {

    @IBOutlet weak var medicalCenterCityLabel: UILabel!
    @IBOutlet weak var clinicImageView: UIImageView!
    @IBOutlet weak var medicalCenterNameLabel: UILabel!
    @IBOutlet weak var callClinicButton: UIButton!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var chekInDateLabel: UILabel!
    @IBOutlet weak var clinicView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        clinicView.layer.cornerRadius = 5.0
        clinicImageView.layer.cornerRadius = 5.0
        clinicView.layer.borderWidth = 1.0
        clinicView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        
        // Initialization code
    }
    func updateClinicUI(clinicInfo: MyClinicModel) {
        medicalCenterCityLabel.text = clinicInfo.medicalCenterCity
        medicalCenterNameLabel.text = clinicInfo.medicalCenterName
        chekInDateLabel.text = clinicInfo.checkInDate
        checkOutDateLabel.text = clinicInfo.checkOutDate
        clinicImageView.image = UIImage(named: clinicInfo.clinicImage)
    }
    }
    

