//
//  EventModel.swift
//  Beamore
//
//  Created by Onur Celik on 05/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class EventModel {
    var eventKey: String
    var eventName: String
    var eventEmail: String
    var eventStartDate: Date
    var eventFinishDate: Date
    var eventStartTime: Date
    var logoUrl: String
    //public LocationDTO Location { get; set; }
    var eventCategory: String
    var isPublish: Bool
    
    
    init(_ json: [String:AnyObject]) {
        if let eventKey = json["EventKey"] as? String { self.eventKey = eventKey }
        else { self.eventKey = "" }
        
        if let eventName = json["EventName"] as? String { self.eventName = eventName }
        else { self.eventName = "" }
        
        if let eventEmail = json["EventEmail"] as? String { self.eventEmail = eventEmail }
        else { self.eventEmail = "" }
        
        if let eventStartDate = json["EventStartDate"] as? Date { self.eventStartDate = eventStartDate }
        else { self.eventStartDate = Date() }
        
        if let eventFinishDate = json["EventFinishDate"] as? Date { self.eventFinishDate = eventFinishDate }
        else { self.eventFinishDate = Date() }
        
        if let eventStartTime = json["EventStartTime"] as? Date { self.eventStartTime = eventStartTime }
        else { self.eventStartTime = Date() }
        
        if let logoUrl = json["LogoUrl"] as? String { self.logoUrl = logoUrl }
        else { self.logoUrl = "" }
        
        if let eventCategory = json["EventCategory"] as? String { self.eventCategory = eventCategory }
        else { self.eventCategory = "" }
        
        if let isPublish = json["IsPublish"] as? Bool { self.isPublish = isPublish }
        else { self.isPublish = false }
    }
}
