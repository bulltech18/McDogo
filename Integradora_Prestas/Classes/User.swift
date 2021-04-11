//
//  User.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 23/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class User: Codable {
    var username: String
    var pwd: String
    
    init(_ username:String, _ pwd:String){
        self.username = username
        self.pwd = pwd
    }
    
}
