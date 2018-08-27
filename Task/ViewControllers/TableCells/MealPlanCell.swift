//
//  MealPlanCell.swift
//  Task
//
//  Created by Armin Spahic on 18/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit

class MealPlanCell: UITableViewCell {

    
    @IBOutlet weak var dessert: UILabel!
    @IBOutlet weak var mainMeal: UILabel!
    @IBOutlet weak var mealView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mealView.layer.cornerRadius = 5.0
        mealView.layer.borderWidth = 1.0
        mealView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        // Initialization code
    }

    func updateMealUI(meal: MealPlan ) {
        mainMeal.text = meal.mealDescription
        dessert.text = meal.dessert
    }
    
}
