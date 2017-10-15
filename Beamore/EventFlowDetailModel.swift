//
//  EventFlowDetailModel.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class EventFlowDetailModel {
    var flowId: Int
    var header: String
    var explain: String
    var company: String
    
    init(_ json: [String:AnyObject]) {
        if let flowId = json["FlowId"] as? Int { self.flowId = flowId }
        else { self.flowId = 0 }
        
        if let header = json["Header"] as? String { self.header = header }
        else { self.header = "" }
        
        if let explain = json["Explain"] as? String { self.explain = explain }
        else { self.explain = "" }
        
        if let company = json["Company"] as? String { self.company = company }
        else { self.company = "" }
    }
}
