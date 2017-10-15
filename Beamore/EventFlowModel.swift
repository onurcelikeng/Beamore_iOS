//
//  EventFlowModel.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class EventFlowModel {
    let status: Int
    let message: String
    let data: [Datum]
    
    init(_ json: [String:AnyObject]) {
        if let status = json["Status"] as? Int { self.status = status }
        else { self.status = 0 }
        
        if let message = json["Message"] as? String { self.message = message }
        else { self.message = "" }
        
        if let data = json["Data"] as? [[String:AnyObject]] {
            var result = [Datum]()
            for obj in data {
                result.append(Datum(obj))
            }
            self.data = result
        } else {
            self.data = [Datum]()
        }
    }
}

class Datum {
    let flowDay: Int
    let flowDate: String
    let isDone: Bool
    let flowDayDetail: [FlowDayDetail]
    
    init(_ json: [String:AnyObject]) {
        if let flowDay = json["FlowDay"] as? Int { self.flowDay = flowDay }
        else { self.flowDay = 0 }
        
        if let flowDate = json["FlowDate"] as? String { self.flowDate = flowDate }
        else { self.flowDate = "" }
        
        if let isDone = json["IsDone"] as? Bool { self.isDone = isDone }
        else { self.isDone = false }
        
        if let flowDayDetail = json["FlowDayDetail"] as? [[String:AnyObject]] {
            var result = [FlowDayDetail]()
            for obj in flowDayDetail {
                result.append(FlowDayDetail(obj))
            }
            self.flowDayDetail = result
        } else {
            self.flowDayDetail = [FlowDayDetail]()
        }
    }
}

class FlowDayDetail {
    let flowTime: String
    let flowName: String
    let flowId: Int
    let isDone: Bool
    
    init(_ json: [String:AnyObject]) {
        if let flowTime = json["FlowTime"] as? String { self.flowTime = flowTime }
        else { self.flowTime = "" }
        
        if let flowName = json["FlowName"] as? String { self.flowName = flowName }
        else { self.flowName = "" }
        
        if let flowId = json["FlowId"] as? Int { self.flowId = flowId }
        else { self.flowId = 0 }
        
        if let isDone = json["IsDone"] as? Bool { self.isDone = isDone }
        else { self.isDone = false }
    }
}

