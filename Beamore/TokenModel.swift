//
//  TokenModel.swift
//  Beamore
//
//  Created by Onur Celik on 21/09/2017.
//  Copyright © 2017 Onur Celik. All rights reserved.
//

import Foundation

class TokenModel {
    var access_token: String
    var token_type: String?
    var expires_in: Int?
    var role: String?
    var email: String?
    
    init(_ json: [String:AnyObject]) {
        if let access_token = json["access_token"] as? String { self.access_token = access_token }
        else { self.access_token = "" }
        
        if let token_type = json["token_type"] as? String { self.token_type = token_type }
        else { self.token_type = "" }
        
        if let role = json["Role"] as? String { self.role = role }
        else { self.role = "" }
        
        if let email = json["Email"] as? String { self.email = email }
        else { self.email = "" }
    }
    
}
