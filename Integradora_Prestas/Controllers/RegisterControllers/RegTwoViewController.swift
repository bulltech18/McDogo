//
//  RegTwoViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 27/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class RegTwoViewController: UIViewController {

    @IBOutlet weak var tf_mascota: UITextField!
    @IBOutlet weak var btn_register: UIButton!
    @IBOutlet weak var DogImage: UIImageView!
    @IBOutlet weak var btn_escoger: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_register.round()
        btn_escoger.round()
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func HideKeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func Registrar(_ sender: UIButton) {
        
    }
    
}
extension RegTwoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            DogImage.image = image
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
