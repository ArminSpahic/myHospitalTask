//
//  Doctor Model.swift
//  Task
//
//  Created by Armin Spahic on 16/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation


struct DoctorModel {
    
    var doctorName = ""
    var doctorPosition = ""
    var doctorImage = ""
    
    init(doctorName: String, doctorPosition: String, doctorImage: String) {
        self.doctorName = doctorName
        self.doctorPosition = doctorPosition
        self.doctorImage = doctorImage
    }
}
