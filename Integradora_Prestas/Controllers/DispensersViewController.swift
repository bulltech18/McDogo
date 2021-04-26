//
//  DispensersViewController.swift
//  Integradora_Prestas
//
//  Created by Mac10 on 23/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Alamofire
class DispensersViewController: UIViewController {

    @IBOutlet weak var dispenserview: UIView!
    @IBOutlet weak var prueba_btn: UIButton!
    @IBOutlet weak var btn_agregar: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_agregar.round()
        dispenserview.roundBit()
        getDispensa()
        
    }
    
   
    
    
    @IBAction func addDispenser(_ sender: Any) {
        self.performSegue(withIdentifier: "ScannSegue", sender: nil)
    }
    
    
    @IBAction func prueba(_ sender: UIButton) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Opciones", message: nil, preferredStyle: .actionSheet)

            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)

            let saveActionButton = UIAlertAction(title: "Croquetas", style: .default)
                { _ in
                self.performSegue(withIdentifier: "CroquetaSegue", sender: nil)
            }
            actionSheetControllerIOS8.addAction(saveActionButton)

            let deleteActionButton = UIAlertAction(title: "Agua", style: .default)
                { _ in
                self.performSegue(withIdentifier: "AguaSegue", sender: nil)
            }
            actionSheetControllerIOS8.addAction(deleteActionButton)
            self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    func getDispensa(){
        AF.request(App.shared.API+"usuarios/getdispensa", method: .get, parameters: ["token":App.shared.token]).responseData{ (response) in
            do {
                guard let data = response.value else { return }
                let decoder = JSONDecoder()
                let disp = try decoder.decode(Dispensador.self, from: data)
                if disp.data.isEmpty{
                    
                    self.dispenserview.isHidden = true
                }else{
                    
                    self.dispenserview.isHidden = false
                }
              
                
            }catch {
                print("Error en la serializacion \(error):")
             
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

}
