//
//  Pet.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 11/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Pet: Codable{
    var name: String
    var foto: String
    
    init(_ name:String){
        self.name = name
        self.foto = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "nombre"
        case foto = "foto"
    }
    
    func registarPerrito(image: UIImage, vc: UIViewController){
        
        let imgData = image.jpegData(compressionQuality: 0.2)
        
        let parameters = ["nombre": self.name, "token": App.shared.token] //Optional for extra parameter
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData!, withName: "foto",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            } //Optional for extra parameters
        },
        to:App.shared.API+"perros/"+"registrarperrito").response {response in debugPrint(response)
            switch response.result{
            case .success( _):
                do{
                    if response.response?.statusCode == 201{
                        //vc.alertDefault(with: "Usuario Registrado", andWithMsg: "Usuario y mascota registrados con exito")
                        let alert = UIAlertController(title: "Usuario Registrado", message: "El usuario y la mascota han sido registrados con exito", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            App.shared.NewUser.logout()
                            vc.performSegue(withIdentifier: "unwindToLogin", sender: vc)
                        }))
                        vc.present(alert, animated: true, completion: nil)
                        
                        //vc.navigationController?.popToRootViewController(animated: true)
                        print("Ok")
                    }else{
                        print(response.response)
                    }
                    
                }catch {
                    print(error.localizedDescription)
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    //======================Trae la imagen del perrito=============================
    func getImage(_ img: UIImageView){
        AF.download(App.shared.API+"perros/getperritosimg", parameters: ["token": App.shared.token]).responseData { response in
            if let data = response.value {
                
                let imgg = UIImage(data: data)
                img.image = imgg
                img.layer.masksToBounds = true
                img.layer.cornerRadius = img.bounds.width / 2
                
                
            }
        }
        
    }
}
