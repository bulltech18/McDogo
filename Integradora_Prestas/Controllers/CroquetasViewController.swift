//
//  CroquetasViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 19/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import Starscream

class CroquetasViewController: UIViewController, WebSocketDelegate {

    @IBOutlet weak var btn_rellenar: UIButton!
    @IBOutlet weak var lbl_croquetaslvl: UILabel!
    @IBOutlet weak var percentageView: UIView!
    var isConnected = false
    var socket:WebSocket!
    override func viewDidLoad() {
        super.viewDidLoad()
        percentageView.roundView()
        btn_rellenar.round()
        
        var request = URLRequest(url: URL(string: "ws://3.18.112.81/ws")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        
    }
    
    @IBAction func Rellenar(_ sender: Any) {
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Opciones", message: nil, preferredStyle: .actionSheet)

            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)

            let saveActionButton = UIAlertAction(title: "25", style: .default)
                { _ in
                self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"croquetas\", \"event\": \"message\",\"data\": \(1) }}")

               
            }
            actionSheetControllerIOS8.addAction(saveActionButton)

            let deleteActionButton = UIAlertAction(title: "50", style: .default)
                { _ in
                self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"croquetas\", \"event\": \"message\",\"data\": \(2) }}")
            }
            actionSheetControllerIOS8.addAction(deleteActionButton)
        let ThreeActionButton = UIAlertAction(title: "75", style: .default)
            { _ in
            self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"croquetas\", \"event\": \"message\",\"data\": \(3) }}")
           
        }
        actionSheetControllerIOS8.addAction(ThreeActionButton)
        let FourActionButton = UIAlertAction(title: "100", style: .default)
            { _ in
            self.socket.write(string: "{\"t\":\(7),\"d\": {\"topic\": \"croquetas\", \"event\": \"message\",\"data\": \(4) }}")
        }
        actionSheetControllerIOS8.addAction(FourActionButton)
            self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                socket.write(string: "{\"t\":\(1),\"d\": {\"topic\": \"croquetas\" }}")
                socket.write(string: "{\"t\":\(1),\"d\": {\"topic\": \"croquetaslvl\" }}")
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
                        if datos["topic"] as! String == "croquetaslvl"{
                            let datos2:NSDictionary = datos["data"] as! NSDictionary
                            lbl_croquetaslvl.text! = "\(datos2["dato"]!)"+"%"
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
    
}
