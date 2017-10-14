//
//  AccountService.swift
//  Beamore
//
//  Created by Onur Celik on 21/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class AccountService {
    private let token = UserDefaults.standard.string(forKey: "token")

    
    public func register(username: String, email: String, password: String, completionHandler: @escaping (ResultModel) -> Void) {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        
        let postData = NSMutableData(data: "Username=\(username)".data(using: String.Encoding.utf8)!)
        postData.append("&Email=\(email)".data(using: String.Encoding.utf8)!)
        postData.append("&Password=\(password)".data(using: String.Encoding.utf8)!)
        postData.append("&Client_Id=3f6405bd-b8d1-4dbb-8550-43f36d1fbb91".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/api/account/register")! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
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
        
        dataTask.resume()
    }
    
    public func login(username: String, password: String, completionHandler: @escaping (TokenModel) -> Void) {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]

        let postData = NSMutableData(data: "UserName=\(username)".data(using: String.Encoding.utf8)!)
        postData.append("&Password=\(password)".data(using: String.Encoding.utf8)!)
        postData.append("&grant_type=password".data(using: String.Encoding.utf8)!)
        postData.append("&client_id=dd08c316-271d-4d72-bbd0-18c7aa5856b1".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://beamoredevelopmentapi.azurewebsites.net/token")! as URL)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if let _data = data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: _data) as? [String: AnyObject] {
                        let model = TokenModel(json)
                        completionHandler(model)
                    }
                } catch { }
            }
        })
        dataTask.resume()
    }
    
    public func forgetPassword(email: String) {
        do {
            let headers = [
                "content-type": "application/json",
                "accept-language": "en-US",
                "cache-control": "no-cache"
            ]
            let parameters = [
                "Email": "eersinyildizz@gmail.com",
                "Client_Id": "dd08c316-271d-4d72-bbd0-18c7aa5856b1"
                ] as [String : Any]
            
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:62755/api/account/forgotpassword")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    
                } else {
                    let httpResponse = response as? HTTPURLResponse
                }
            })
            
            dataTask.resume()
        } catch { }
    }
    
    public func updatePassword(email: String, password: String, GuidPassword: String) {
        do {
            let headers = [
                "content-type": "application/json",
                "cache-control": "no-cache"
            ]
            let parameters = [
                "GuidPassword": "f00d4921-6f86-4bd8-b503-6d47ceabec25",
                "Email": "eersinyildizz@gmail.com",
                "NewPassword": "123"
                ] as [String : Any]
        
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://localhost:62755/api/account/updatepassword")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
        
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                }
            })
            
            dataTask.resume()
        } catch { }
    }
    
}
