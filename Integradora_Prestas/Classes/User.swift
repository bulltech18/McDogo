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
    var logged:Bool
    
    init(_ username:String, _ pwd:String){
        self.username = username
        self.pwd = pwd
        self.logged = false
        
    }
    
    func registrarUsuario(_ vc: UIViewController){
        AF.request(App.shared.API+"registrar",method: .post, parameters: ["usuario":self.username,"password":self.pwd], encoding: JSONEncoding.default).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 201{
                        self.loginForRegister(vc)
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
    func login(_ vc: UIViewController){
        
        AF.request(App.shared.API+"login", method: .post, parameters: ["usuario":self.username,"password":self.pwd]).responseData{ (response) in
            do {
                guard let data = response.value else { return }
                let decoder = JSONDecoder()
                let auth = try decoder.decode(Auth.self, from: data)
                if !auth.token.isEmpty{
                    App.shared.token = auth.token
                    vc.performSegue(withIdentifier: "HomeSegue", sender: nil)
                   
                }else{
                    vc.alertDefault(with: "Erroor", andWithMsg: "EROOOOR")
                }
                
                
                //print("Hola")
                
            }catch {
                print("Error en la serializacion \(error):")
                vc.alertDefault(with: "Error", andWithMsg: "Error en tus credenciales")
            }
        }
        
        
    }
    func loginForRegister(_ vc: UIViewController){
        AF.request(App.shared.API+"login", method: .post, parameters: ["usuario":self.username,"password":self.pwd]).responseData{ (response) in
            do {
                guard let data = response.value else { return }
                let decoder = JSONDecoder()
                let auth = try decoder.decode(Auth.self, from: data)
                if !auth.token.isEmpty{
                    App.shared.token = auth.token
                    print(auth.token!)
                    vc.performSegue(withIdentifier: "nxtSegue", sender: nil)
                }else{
                    print("error")
                }
                
                //print(auth.token!)
                //print("Hola")
                
            }catch {
                print("Error en la serializacion \(error):")
                //vc.alertDefault(with: "Error", andWithMsg: "Error en tus credenciales")
            }
        }
        
        
    }
    func logout(){
        AF.request(App.shared.API+"logout", method: .post, parameters: ["token": App.shared.token]).responseJSON(){ response in
                    debugPrint(response)
                }
        
    }
    func actualizarUsuario(_ vc: UIViewController, _ new:String){
        
        AF.request(App.shared.API+"usuarios/"+"actualizar",method: .put, parameters: ["token":App.shared.token,"usuario":new, "password": self.pwd], encoding: JSONEncoding.default).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                
                //let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if response.response?.statusCode == 200{
                    App.shared.LoggedUser.username = new
                    vc.alertDefault(with: "Usuario Actualizado", andWithMsg: "Usuario actualizado correctamente")
                    vc.viewDidLoad()
                }else{
                    vc.alertDefault(with: "Error", andWithMsg: "No se pudo actualizar el usuario. Pruebe con otro nombre")
                }
                
                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
    func actualizarContraseña(_ vc: UIViewController, _ new:String){
        
        AF.request(App.shared.API+"usuarios/"+"actualizar",method: .put, parameters: ["token":App.shared.token,"usuario":self.username, "password": new], encoding: JSONEncoding.default).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                
                //let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if response.response?.statusCode == 200{
                    vc.alertDefault(with: "Usuario Actualizado", andWithMsg: "Usuario actualizado correctamente")
                    vc.viewDidLoad()
                }else{
                    vc.alertDefault(with: "Error", andWithMsg: "No se pudo actualizar el usuario.")
                }
                
                
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
        
    }
    
    
    
}
