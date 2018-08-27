//
//  MyClinicModel.swift
//  Task
//
//  Created by Armin Spahic on 19/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class MyClinicModel {
    var medicalCenterCity: String
    var medicalCenterName: String
    var checkInDate: String
    var checkOutDate: String
    var clinicImage: String
    
    init(medicalCenterName: String, checkInDate: String, checkOutDate: String, clinicImage: String, medicalCenterCity: String) {
        self.medicalCenterCity = medicalCenterCity
        self.medicalCenterName = medicalCenterName
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.clinicImage = clinicImage
    }
}
