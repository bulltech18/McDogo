//
//  ProfileViewController.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 23/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {

    @IBOutlet weak var lbl_usuario: UILabel!
    @IBOutlet weak var lbl_user: UILabel!
    @IBOutlet weak var lbl_contraseña: UILabel!
    @IBOutlet weak var btn_logout: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_logout.round()
        App.shared.NewPet.getImage(userImage)
        lbl_user.text = App.shared.LoggedUser.username
        
        
    }
    
    
  
    @IBAction func LogOuut(_ sender: UIButton) {
        App.shared.LoggedUser.logout()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func changeUser(_ sender: UIButton) {
        let ac = UIAlertController(title: "Ingrese el nuevo nombre", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            if !answer.text!.isEmpty{
                App.shared.LoggedUser.actualizarUsuario(self, answer.text!)
            }else{
                self.alertDefault(with: "Campos vacios", andWithMsg: "Asegurate de llenar todos los campos")
            }
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
        let ac = UIAlertController(title: "Ingrese los campos", message: nil, preferredStyle: .alert)
        ac.addTextField{ (textField) in
            textField.placeholder = "Ingresa tu contraseña actual"
        }
        ac.addTextField{ (textField) in
            textField.placeholder = "Ingresa tu nueva contraseña"
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let actual_pass = ac.textFields![0]
            let new_pass = ac.textFields![1]
            if !actual_pass.text!.isEmpty && !new_pass.text!.isEmpty{
                if actual_pass.text != App.shared.LoggedUser.pwd{
                    self.alertDefault(with: "Contraseña incorrecta", andWithMsg: "La contraseña actual no coincide")
                }else{
                    App.shared.LoggedUser.actualizarContraseña(self, new_pass.text!)
                    
                }
            }else{
                self.alertDefault(with: "Campos Vacios", andWithMsg: "Asegurate de llenar todos los campos")
            }
           
            
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
