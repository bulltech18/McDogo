//
//  Pet.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 11/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Alamofire

class Pet: Codable {
    var name: String
    var foto: String
    
    init(_ name:String, _ foto:String){
        self.name = name
        self.foto = foto
    }
}
