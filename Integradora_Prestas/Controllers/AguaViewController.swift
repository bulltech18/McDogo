//
//  AguaViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 19/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Starscream

class AguaViewController: UIViewController, WebSocketDelegate {
    
    @IBOutlet weak var lbl_NivelAgua: UILabel!
    @IBOutlet weak var btn_temp: UIButton!
    @IBOutlet weak var lbl_temperatura: UILabel!
    @IBOutlet weak var btn_rellenar: UIButton!
    @IBOutlet weak var TempView: UIView!
    @IBOutlet weak var NivelView: UIView!
    var isConnected = false
    var socket:WebSocket!
    override func viewDidLoad() {
        super.viewDidLoad()
        NivelView.roundView()
        TempView.roundView()
        btn_rellenar.round()
        btn_temp.round()
        
        var request = URLRequest(url: URL(string: "ws://3.18.112.81/ws")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    

    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                sendData()
                socket.write(string: "{\"t\":\(1),\"d\": {\"topic\": \"auga\" }}")
                socket.write(string: "{\"t\":\(1),\"d\": {\"topic\": \"temperaturalvl\" }}")
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                if let data = string.data(using: .utf8) {
                    guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else { return }
                    print(json)
                    if json["t"] as! Int == 7{
                        let datos:NSDictionary = json["d"] as! NSDictionary
                        if datos["topic"] as! String == "agualvl"{
                            let datos2:NSDictionary = datos["data"] as! NSDictionary
                            
                            lbl_NivelAgua.text = "\(datos2["dato"]!)"+"%"
                        }else if datos["topic"] as! String == "temperaturalvl"{
                            let datos2:NSDictionary = datos["data"] as! NSDictionary
                            
                            lbl_temperatura.text = "\(datos2["dato"]!)"+"ºC"
                            
                        }
                      
                    }
                    
                    
                    
                    //

                    /*print("Received text: \(datos["data"])")
                    let connId = datos["connId"] as? String*/
                }
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                //handleError(error)
            }
    }
    
    func sendData(){
        socket.write(string: "{\"t\":\(1),\"d\": {\"topic\": \"agualvl\" }}")
    }
    
    
    @IBAction func Rellenar(_ sender: Any) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Opciones", message: nil, preferredStyle: .actionSheet)

            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)

            let saveActionButton = UIAlertAction(title: "25", style: .default)
                { _ in
                self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(1) }}")

               
            }
            actionSheetControllerIOS8.addAction(saveActionButton)

            let deleteActionButton = UIAlertAction(title: "50", style: .default)
                { _ in
                self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(2) }}")
            }
            actionSheetControllerIOS8.addAction(deleteActionButton)
        let ThreeActionButton = UIAlertAction(title: "75", style: .default)
            { _ in
            self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(3) }}")
           
        }
        actionSheetControllerIOS8.addAction(ThreeActionButton)
        let FourActionButton = UIAlertAction(title: "100", style: .default)
            { _ in
            self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(4) }}")
            
        }
        actionSheetControllerIOS8.addAction(FourActionButton)
            self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    @IBAction func AjustarTemperatura(_ sender: Any) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Opciones", message: nil, preferredStyle: .actionSheet)

            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)

            let saveActionButton = UIAlertAction(title: "25", style: .default)
                { _ in
                self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(1) }}")

               
            }
            actionSheetControllerIOS8.addAction(saveActionButton)

            let deleteActionButton = UIAlertAction(title: "50", style: .default)
                { _ in
                self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(2) }}")
            }
            actionSheetControllerIOS8.addAction(deleteActionButton)
        let ThreeActionButton = UIAlertAction(title: "75", style: .default)
            { _ in
            self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(3) }}")
           
        }
        actionSheetControllerIOS8.addAction(ThreeActionButton)
        let FourActionButton = UIAlertAction(title: "100", style: .default)
            { _ in
            self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"auga\", \"event\": \"message\",\"data\": \(4) }}")
            
        }
        actionSheetControllerIOS8.addAction(FourActionButton)
            self.present(actionSheetControllerIOS8, animated: true, completion: nil)
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
