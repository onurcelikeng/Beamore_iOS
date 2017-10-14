//
//  EventParticipantModel.swift
//  Beamore
//
//  Created by Onur Celik on 14/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class EventParticipantModel {
    var data: Int
    var status: Int
    var message: String
    
    init(_ json: [String:AnyObject]) {
        if let data = json["Data"] as? Int { self.data = data }
        else { self.data = 0 }
        
        if let status = json["Status"] as? Int { self.status = status }
        else { self.status = 0 }
        
        if let message = json["Message"] as? String { self.message = message }
        else { self.message = "" }
    }
}
