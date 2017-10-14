//
//  NotificationModel.swift
//  Beamore
//
//  Created by Onur Celik on 12/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class NotificationModel {
    var notificationId: String
    var message: String
    var createdTime: String
    
    init(_ json: [String:AnyObject]) {
        if let notificationId = json["NotificationId"] as? String { self.notificationId = notificationId }
        else { self.notificationId = "" }
        
        if let message = json["Message"] as? String { self.message = message }
        else { self.message = "" }
        
        if let createdTime = json["CreatedTime"] as? String { self.createdTime = createdTime }
        else { self.createdTime = "" }
    }

}
