//
//  TherapyPlanCell.swift
//  Task
//
//  Created by Armin Spahic on 16/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit

class TherapyPlanCell: UITableViewCell {

    @IBOutlet weak var dateToLabel: UILabel!
    @IBOutlet weak var dateFromLabel: UILabel!
    @IBOutlet weak var todaysDateLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var typeThree: UILabel!
    @IBOutlet weak var placeThree: UILabel!
    @IBOutlet weak var placeTwo: UILabel!
    @IBOutlet weak var placeOne: UILabel!
    @IBOutlet weak var typeTwo: UILabel!
    @IBOutlet weak var typeOne: UILabel!
    @IBOutlet weak var timeThree: UILabel!
    @IBOutlet weak var timeTwo: UILabel!
    @IBOutlet weak var timeOne: UILabel!
    @IBOutlet weak var therapyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        therapyView.layer.cornerRadius = 5.0
        therapyView.layer.borderWidth = 1.0
        therapyView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        // Initialization code
    }
    
    func updateTherapyPlan(therapies: [Therapy]) {
        timeOne.text = therapies[0].time
        timeTwo.text = therapies[1].time
        timeThree.text = therapies[2].time
        placeOne.text = therapies[0].planPlace
        placeTwo.text = therapies[1].planPlace
        placeThree.text = therapies[2].planPlace
        typeOne.text = therapies[0].planType
        typeTwo.text = therapies[1].planType
        typeThree.text = therapies[2].planType
    }
    
    func updateDatesInTherapyPlan(dates: DateModel) {
        todayLabel.text = dates.today
        todaysDateLabel.text = dates.todaysDate
        dateFromLabel.text = dates.dateFrom
        dateToLabel.text = dates.dateTo
        
    }
    
}
