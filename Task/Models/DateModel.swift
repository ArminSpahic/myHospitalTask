//
//  DateModel.swift
//  Task
//
//  Created by Armin Spahic on 19/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class DateModel {
    
    var today: String = ""
    var todaysDate: String = ""
    var dateFrom: String = ""
    var dateTo: String = ""
    
    init(today: String, todaysDate: String, dateFrom: String, dateTo: String) {
        self.today = today
        self.todaysDate = todaysDate
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
}
