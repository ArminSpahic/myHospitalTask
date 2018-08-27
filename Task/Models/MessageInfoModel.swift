//
//  MessageInfoModel.swift
//  Task
//
//  Created by Armin Spahic on 19/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class MessageInfoModel {
    
    var messageTitle: String
    var messageText: String
    
    init(messageTitle: String, messageText:String) {
        self.messageTitle = messageTitle
        self.messageText = messageText
    }
    
}
