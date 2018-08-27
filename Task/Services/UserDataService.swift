//
//  UserDataService.swift
//  Task
//
//  Created by Armin Spahic on 19/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class UserDataService {

  static let shared = UserDataService()
    let defaults = UserDefaults.standard
  
    
    func populateData(completion: (HomePageViewModel) -> Void) {
        
        let viewModel = HomePageViewModel()
        
        viewModel.presentOrder = UserDefaults.standard.stringArray(forKey: "SavedOrderArray") ?? ["therapy","meal","clinic","question"]
        var therapies : [Therapy] = [];
        therapies.append(Therapy(time: "9:30", planType: "Physiotherapy", planPlace: "Raum 505, Block F"))
        therapies.append(Therapy(time: "10:30", planType: "Jogging", planPlace: "Raum 3200, Building A"))
        therapies.append(Therapy(time: "15:00", planType: "Physiotherapy", planPlace: "Raum 2141, Pavilion 25"))
        
        viewModel.Therapy = TherapyViewModel(therapies: therapies, duritationStart: Date.init(), duritationEnd: Date.init())
        viewModel.dates = DateModel(today: "Heute", todaysDate: "Montag 13.", dateFrom: "26. Oktober", dateTo: "15. November")
        viewModel.mealPlan = MealPlan(mealDescription: "Gebackene Hahnschenschegel mit Pommes Frites und Mischgemuse mit Apfel", dessert: "Frankfurter Kranz")
        viewModel.doctorInfo = DoctorModel(doctorName: "Dr. Wolfgang Wechsler", doctorPosition: "Head Physicist", doctorImage: "doctorImage")
        viewModel.messageInfo = MessageInfoModel(messageTitle: "Hello Michael", messageText: "we wish you a very pleasent stay. Please take a look on your checklist to not forget anything important")
        viewModel.myClinicInfo = MyClinicModel(medicalCenterName: "Rehabilitationsklinik fur Orthopedie und Geriatrie", checkInDate: "26. Oktober", checkOutDate: "15. November", clinicImage: "center", medicalCenterCity: "- Berlin")
        viewModel.questions.append(QuestionModel(questionName: "Anamnesis"))
        viewModel.questions.append(QuestionModel(questionName: "Feedback"))
        viewModel.questions.append(QuestionModel(questionName: "Scoring"))
        for i in 1...NumberOfQuestions().anamnesisQuestionCount {
            viewModel.anamnesisAnswers.append(AnamnesisAnswersModel(anamnesisAnswers: "Anamnesis Answer:\(i)"))
            if i == 9 {
                break
            }
        }
        for i in 1...NumberOfQuestions().feedbackQuestionCount {
            viewModel.feedbackAnswers.append(FeedbackAnswersModel(feedbackAnswers: "Feedback Answer:\(i)"))
            if i == 3 {
                break
            }
        }
        for i in 1...NumberOfQuestions().scoringQuestionCount {
            viewModel.scoringAnswers.append(ScoringAnswersModel(scoringAnswers: "Scoring Answer:\(i)"))
            if i == 3 {
                break
            }
        }
        completion(viewModel)
        
    }
    }
    

