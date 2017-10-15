//
//  SurveyModel.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class SurveyModel {
    var questionId: Int
    var questionText: String
    var createdTime: String
    var isAnswared: Bool
    
    init(_ json: [String:AnyObject]) {
        if let questionId = json["QuestionId"] as? Int { self.questionId = questionId }
        else { self.questionId = 0 }
        
        if let questionText = json["QuestionText"] as? String { self.questionText = questionText }
        else { self.questionText = "" }
        
        if let createdTime = json["CreatedTime"] as? String { self.createdTime = createdTime }
        else { self.createdTime = "" }
        
        if let isAnswared = json["IsAnswared"] as? Bool { self.isAnswared = isAnswared }
        else { self.isAnswared = false }
    }
    
}
