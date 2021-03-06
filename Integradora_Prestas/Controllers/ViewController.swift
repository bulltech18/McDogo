//
//  ViewController.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 22/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tf_usuario: UITextField!
    @IBOutlet weak var btn_sesion: UIButton!
    @IBOutlet weak var tf_contraseña: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_sesion.round()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        tf_usuario.text = ""
        tf_contraseña.text = ""
    }

    @IBAction func IniciarSesion(_ sender: UIButton) {
        if !tf_usuario.text!.isEmpty && !tf_contraseña.text!.isEmpty{
            App.shared.LoggedUser.username =  tf_usuario.text!
            App.shared.LoggedUser.pwd = tf_contraseña.text!
            let vc = self
            App.shared.LoggedUser.login(vc)
            
            
        }else{
            alertDefault(with: "Datos Requeridos", andWithMsg: "Asegurate de llenar todos los campos")
        }
    }
    
    @IBAction func CrearCuenta(_ sender: UIButton) {
        self.performSegue(withIdentifier: "RegisterSegue", sender: nil)
    }
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
    }
    
}

