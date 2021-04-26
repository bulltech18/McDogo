//
//  HomeViewController.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 23/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {

    @IBOutlet weak var lbl_dispensadores: UILabel!
    @IBOutlet weak var lbl_usuario: UILabel!
    @IBOutlet weak var btn_detalles: UIButton!
    
    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_usuario.text=App.shared.LoggedUser.username
        btn_detalles.round()
        App.shared.NewPet.getImage(userImg)
        getDispensa()
       

        
        
    }
    func getDispensa(){
        AF.request(App.shared.API+"usuarios/getdispensa", method: .get, parameters: ["token":App.shared.token]).responseData{ (response) in
            do {
                guard let data = response.value else { return }
                let decoder = JSONDecoder()
                let disp = try decoder.decode(Dispensador.self, from: data)
                if disp.data.isEmpty{
                    
                    self.lbl_dispensadores.text! = "\(0)"
                    
                }else{
                    self.lbl_dispensadores.text! = "\(1)"
                    
                }
              
                
            }catch {
                self.lbl_dispensadores.text! = "\(1)"
                print("Error en la serializacion \(error):")
               
             
            }
        }
        
        
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


