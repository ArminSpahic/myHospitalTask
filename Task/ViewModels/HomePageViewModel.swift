//
//  HomePageViewModel.swift
//  Task
//
//  Created by Armin Spahic on 19/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class HomePageViewModel {
    var presentOrder : [String] = [];
    var login: String = ""
    var Therapy : TherapyViewModel?
    var mealPlan: MealPlan?
    var dates: DateModel?
    var doctorInfo: DoctorModel?
    var messageInfo: MessageInfoModel?
    var myClinicInfo: MyClinicModel?
    var questions: [QuestionModel] = []
    var anamnesisAnswers: [AnamnesisAnswersModel] = []
    var feedbackAnswers: [FeedbackAnswersModel] = []
    var scoringAnswers: [ScoringAnswersModel] = []
}

class TherapyViewModel {
    var therapies: [Therapy] = []
    var duritationStart : Date?
    var duritationEnd : Date?
    
    init(therapies: [Therapy], duritationStart: Date, duritationEnd:Date) {
        self.therapies = therapies
        self.duritationStart = duritationStart
        self.duritationEnd = duritationEnd
    }
}
