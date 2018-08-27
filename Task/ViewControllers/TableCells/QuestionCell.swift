//
//  QuestionCell.swift
//  Task
//
//  Created by Armin Spahic on 19/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    @IBOutlet weak var anamnesisProgressView: UIProgressView!
    @IBOutlet weak var scoringProgressView: UIProgressView!
    @IBOutlet weak var feedbackProgressView: UIProgressView!
    @IBOutlet weak var scoringAnswerCount: UILabel!
    @IBOutlet weak var feedbackAnswerCount: UILabel!
    @IBOutlet weak var anamnesisAnswerCount: UILabel!
    @IBOutlet weak var scoringQuestionLabel: UILabel!
    @IBOutlet weak var feedbackQuestionLabel: UILabel!
    @IBOutlet weak var anamnesisQuestionLabel: UILabel!    
    @IBOutlet weak var questionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        questionView.layer.cornerRadius = 5.0
        questionView.layer.borderWidth = 1.0
        questionView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        // Initialization code
    }

    func updateQuestions(questions: [QuestionModel]) {
        anamnesisQuestionLabel.text = questions[0].questionName
        feedbackQuestionLabel.text = questions[1].questionName
        scoringQuestionLabel.text = questions[2].questionName
    }
    
}
