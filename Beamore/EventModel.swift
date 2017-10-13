//
//  EventModel.swift
//  Beamore
//
//  Created by Onur Celik on 05/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

public class EventModel {
    var EventKey: String?
    var EventName: String?
    var EventEmail: String?
    var EventStartDate: Date?
    var EventFinishDate: Date?
    var EventStartTime: Date?
    var LogoUrl: String?
    //public LocationDTO Location { get; set; }
    var EventCategory: String?
    var IsPublish: Bool?
    
    init() {
        
    }
    
    init (_ json: [String: AnyObject]) {
        self.EventKey = json["EventKey"] as? String
        self.EventName = json["EventName"] as? String
        self.EventEmail = json["EventEmail"] as? String
        self.EventStartDate = json["EventStartDate"] as? Date
        self.EventFinishDate = json["EventFinishDate"] as? Date
        self.EventStartTime = json["EventStartTime"] as? Date
        self.LogoUrl = json["LogoUrl"] as? String
        self.EventCategory = json["EventCategory"] as? String
        self.IsPublish = json["IsPublish"] as? Bool
    }
}
