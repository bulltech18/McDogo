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
    var LoggedUser = User("", "")
    var API = "http://127.0.0.1:3333/"
}
