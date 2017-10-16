//
//  NotificationService.swift
//  Beamore
//
//  Created by Onur Celik on 12/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class NotificationService {
    
    public func getEventNotifications(eventKey: String, completionHandler: @escaping ([NotificationModel]) -> Void) {
        var list: [NotificationModel] = []
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/notification/notifications?eventKey=\(eventKey)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        let notifications = json["Data"] as? [[String: AnyObject]]
                        if notifications != nil {
                            for notification in notifications! {
                                list.append(NotificationModel(notification))
                            }
                        }
                        
                        completionHandler(list)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
}
