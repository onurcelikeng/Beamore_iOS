//
//  EventService.swift
//  Beamore
//
//  Created by Onur Celik on 04/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class EventService {
    let token = "VREQO3gERnpmm-lYUj0nisi0UKP1mI52KiiSt0zBO6NQ_iQ4oYsDksWItII0pcaiFA52YfljnoWcmyhmwcT5q_6i5Bo8zKPKIymN2N6zrtTjY89p8Axn79p14elhxeVlEaTLLPHEJZzw5T6CJpCVA30rN73kaBIDIe2plHgsrDGouu8mnqsY0Hs7GCuGLukbGtjV7oa30f4PyyNa71lO3U69k5NudJfZpG70e6Ffx4lcNLM6KZ26FpBzTaz6DPb0KkbJHKCruSAHUgpRhJpVz91pOcHMoLubKXrTgwF98waNfuRSoXrm_fsHeM8fPJjLfJtloj0aniEoomyAXVYEDw"
    
    
    public func EventService() { }
    
    
    public func getAllEvents(completionHandler: @escaping ([EventModel]) -> Void) {
        var list: [EventModel] = []
        let headers = [
            "authorization": "bearer \(token)",
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/events")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        let events = json["Data"] as? [[String: AnyObject]]
                        
                        for event in events! {
                            list.append(EventModel(event))
                        }
                        completionHandler(list)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func getMyEvents(completionHandler: @escaping ([EventModel]) -> Void) {
        var list: [EventModel] = []
        let headers = [
            "authorization": "bearer \(token)",
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/getmyevents")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        let events = json["Data"] as? [[String: AnyObject]]
                        
                        for event in events! {
                            list.append(EventModel(event))
                        }
                        completionHandler(list)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func getEventDetails(eventKey: String) {
        
    }
    
    public func subscribeEvent(eventKey: String, completionHandler: @escaping (ResultModel) -> Void) {
        var model = ResultModel()
        let headers = [
            "authorization": "bearer \(token)",
            "cache-control": "no-cache",
            "content-type" : "application/json"
        ]
        guard let endpointUrl = URL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/subscribe") else {
            return
        }
        
        var postData = [String:Any]()
        postData["EventKey"] = eventKey
        
        do {
            let data = try JSONSerialization.data(withJSONObject: postData, options: [])
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                if let _data = data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: _data) as? [String: AnyObject] {
                            if let data = json["Data"] as? [String: AnyObject] {
                                model = ResultModel(data)
                                completionHandler(model)
                            }
                        }
                    } catch { }
                }
            })
            task.resume()
        } catch {
            
        }
    }
    
}
