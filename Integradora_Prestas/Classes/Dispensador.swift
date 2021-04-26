//
//  Dispensador.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 18/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import Foundation

struct Dispensador: Decodable {

    let data: [String]!
    
    enum CodingKeys: String, CodingKey {
       
        case data = "data"
    }
}
