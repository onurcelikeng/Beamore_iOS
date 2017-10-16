//
//  SurveyAnswerModel.swift
//  Beamore
//
//  Created by Onur Celik on 16/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class SurveyAnswerModel {
    var optionId: Int
    var optionText: String
    
    init(_ json: [String:AnyObject]) {
        if let optionId = json["OptionId"] as? Int { self.optionId = optionId }
        else { self.optionId = 0 }
        
        if let optionText = json["OptionText"] as? String { self.optionText = optionText }
        else { self.optionText = "" }
    }
}
