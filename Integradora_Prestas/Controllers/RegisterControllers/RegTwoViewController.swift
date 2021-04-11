//
//  RegTwoViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 27/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class RegTwoViewController: UIViewController {

    @IBOutlet weak var btn_register: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_register.round()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func HideKeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
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
