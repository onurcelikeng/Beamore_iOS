//
//  ResultModel.swift
//  Beamore
//
//  Created by Onur Celik on 05/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class ResultModel {
    var isSuccess: Bool
    var message: String
    
    init(_ json: [String:AnyObject]) {
        if let isSuccess = json["IsSuccess"] as? Bool { self.isSuccess = isSuccess }
        else { self.isSuccess = false }
        
        if let message = json["Message"] as? String { self.message = message }
        else { self.message = "" }
    }
}
