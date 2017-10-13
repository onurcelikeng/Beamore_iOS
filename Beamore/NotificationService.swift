//
//  NotificationService.swift
//  Beamore
//
//  Created by Onur Celik on 12/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class NotificationService {
    let token = "VREQO3gERnpmm-lYUj0nisi0UKP1mI52KiiSt0zBO6NQ_iQ4oYsDksWItII0pcaiFA52YfljnoWcmyhmwcT5q_6i5Bo8zKPKIymN2N6zrtTjY89p8Axn79p14elhxeVlEaTLLPHEJZzw5T6CJpCVA30rN73kaBIDIe2plHgsrDGouu8mnqsY0Hs7GCuGLukbGtjV7oa30f4PyyNa71lO3U69k5NudJfZpG70e6Ffx4lcNLM6KZ26FpBzTaz6DPb0KkbJHKCruSAHUgpRhJpVz91pOcHMoLubKXrTgwF98waNfuRSoXrm_fsHeM8fPJjLfJtloj0aniEoomyAXVYEDw"
    
    
    public func NotificationService() { }
    
    
    public func getEventNotifications(eventKey: String, completionHandler: @escaping ([NotificationModel]) -> Void) {
        var list: [NotificationModel] = []
        let headers = [
            "authorization": "bearer \(token)",
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
                        
                        for notification in notifications! {
                            list.append(NotificationModel(notification))
                        }
                        completionHandler(list)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
}
