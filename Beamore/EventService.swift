//
//  EventService.swift
//  Beamore
//
//  Created by Onur Celik on 04/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class EventService {

    public func getAllEvents(completionHandler: @escaping ([EventModel]) -> Void) {
        var list: [EventModel] = []
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
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
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
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
    
    public func getEventParticipant(eventKey:String, completionHandler: @escaping (EventParticipantModel) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/participantnumber?EventKey=\(eventKey)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: AnyObject] {
                        if let data = json as? [String: AnyObject] {
                            let model = EventParticipantModel(data)
                            completionHandler(model)
                        }
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func getEventFlows(eventKey: String, completionHandler: @escaping (EventFlowModel) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/detail?key=\(eventKey)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        if let data = json as? [String: AnyObject] {
                            let model = EventFlowModel(data)
                            completionHandler(model)
                        }
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func getEventFlowDetails(flowId: String, completionHandler: @escaping (EventFlowDetailModel) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/flowdetails?id=\(flowId)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        if let data = json["Data"] as? [String: AnyObject] {
                            let model = EventFlowDetailModel(data)
                            completionHandler(model)
                        }
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func subscribeEvent(eventKey: String, completionHandler: @escaping (ResultModel) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
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
                                let model = ResultModel(data)
                                completionHandler(model)
                            }
                        }
                    } catch { }
                }
            })
            task.resume()
        } catch { }
    }

    public func unSubscribeEvent(eventKey: String, completionHandler: @escaping (ResultModel) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer \(token)",
            "cache-control": "no-cache",
            "content-type" : "application/json"
        ]
        guard let endpointUrl = URL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/event/unsubscribe") else {
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
                                let model = ResultModel(data)
                                completionHandler(model)
                            }
                        }
                    } catch { }
                }
            })
            task.resume()
        } catch { }
    }

}
