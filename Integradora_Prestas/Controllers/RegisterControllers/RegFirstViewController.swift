//
//  RegFirstViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 27/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class RegFirstViewController: UIViewController {

    @IBOutlet weak var tf_usuario: UITextField!
    @IBOutlet weak var tf_contraseña: UITextField!
    @IBOutlet weak var Btn_Next: UIButton!
    @IBOutlet weak var tf_confirmacion: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        Btn_Next.round()
      
    }
    
    @IBAction func HideKeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func NextBtn(_ sender: UIButton) {
        if !tf_usuario.text!.isEmpty && !tf_contraseña.text!.isEmpty && !tf_confirmacion.text!.isEmpty{
            if tf_contraseña.text!==tf_confirmacion.text!{
                App.shared.NewUser.username = tf_usuario.text!
                App.shared.NewUser.pwd = tf_contraseña.text!
                App.shared.LoggedUser.username = tf_usuario.text!
                App.shared.LoggedUser.pwd = tf_contraseña.text!
                App.shared.NewUser.registrarUsuario(self)
            }else{
                alertDefault(with: "Contraseña Incorrecta", andWithMsg: "Asegurate que las contraseñas coincidan")
            }
            
        }else{
            alertDefault(with: "Datos requeridos", andWithMsg: "Asegurate de rellenar todos los campos")
        }
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is RegTwoViewController {
            let vc = segue.destination as? RegTwoViewController
            
        }
    }*/
    

}
