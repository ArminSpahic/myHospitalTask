//
//  TherapyPlanModel.swift
//  Task
//
//  Created by Armin Spahic on 16/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class Therapy {
    
    var time: String = ""
    var planType: String = ""
    var planPlace: String? = ""
  
    init(time: String, planType: String, planPlace:String) {
        self.time = time
        self.planType = planType
        self.planPlace = planPlace
    }
}
