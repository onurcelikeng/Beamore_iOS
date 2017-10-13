//
//  ResultModel.swift
//  Beamore
//
//  Created by Onur Celik on 05/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class ResultModel {
    var IsSuccess: Bool?
    var Message: String?
    
    init() {
        
    }
    
    init (_ json: [String: AnyObject]) {
        self.IsSuccess = json["IsSuccess"] as? Bool
        self.Message = json["Message"] as? String
    }
}
