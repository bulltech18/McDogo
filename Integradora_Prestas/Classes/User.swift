//
//  User.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 23/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Alamofire

class User: Codable {
    var username: String
    var pwd: String
    
    init(_ username:String, _ pwd:String){
        self.username = username
        self.pwd = pwd
    }
    
    func registrarUsuario(){
        AF.request("https://mcdogo.herokuapp.com/registrar",method: .post, parameters: ["usuario":App.shared.NewUser.username,"password":App.shared.NewUser.pwd], encoding: JSONEncoding.default).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 201{
                        print("Ok")
                    }else{
                        print("Nop")
                    }
                    
                }catch {
                    print(error.localizedDescription)
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }
    func login(){
        
        AF.request("https://mcdogo.herokuapp.com/login",method: .post, parameters: ["usuario":App.shared.LoggedUser.username,"password":App.shared.LoggedUser.pwd], encoding: JSONEncoding.default).responseJSON{(response) -> Void in
           
           }
    }
    
    
    
}
