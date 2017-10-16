//
//  SurveyService.swift
//  Beamore
//
//  Created by Onur Celik on 15/10/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class SurveyService {
    
    public func getEventSurveys(eventKey: String, completionHandler: @escaping ([SurveyModel]) -> Void) {
        var list: [SurveyModel] = []
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/survay/survays?EventKey=\(eventKey)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        let surveys = json["Data"] as? [[String: AnyObject]]
                        if surveys != nil {
                            for survey in surveys! {
                                list.append(SurveyModel(survey))
                            }
                        }
                        
                        completionHandler(list)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func getEventSurveyAnswers(questionId: String, completionHandler: @escaping ([SurveyAnswerModel]) -> Void) {
        var list: [SurveyAnswerModel] = []
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/survay/options?questionId=\(questionId)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: Any] {
                        let answers = json["Data"] as? [[String: AnyObject]]
                        if answers != nil {
                            for answer in answers! {
                                list.append(SurveyAnswerModel(answer))
                            }
                        }
                        
                        completionHandler(list)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func sendAnswer(optionId: Int, questionId: Int, completionHandler: @escaping (ResultModel) -> Void) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers = [
            "authorization": "bearer " + token!,
            "cache-control": "no-cache",
            "content-type" : "application/json"
        ]
        guard let endpointUrl = URL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/survay/survayanswer") else {
            return
        }
        
        var postData = [String:Any]()
        postData["OptionId"] = optionId
        postData["QuestionId"] = questionId
        
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
                                print(model.isSuccess)
                                
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
