//
//  App.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 23/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class App: NSObject{
    static let shared = App()
    var NewUser = User("", "")
    var NewPet = Pet("")
    var LoggedUser = User("", "")
    var API = "http://3.18.112.81/"
    var token = ""
    var Image = UIImage(named: "image")
}
