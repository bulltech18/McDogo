//
//  Auth.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 13/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

struct Auth: Decodable {
    let type: String!
    let token: String!
    let refreshToken: String!
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case token = "token"
        case refreshToken = "refreshToken"
    }
    
    

}
