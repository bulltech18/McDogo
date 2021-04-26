//
//  ScannerViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 18/04/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput:AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch {
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        }else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func failed() {
        let alert = UIAlertController(title: "Escaner no soportado", message: "El dispositivo no es compatible con la funcion de escaner, revisa tu camara o que no te encuentres en un emulador", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK",style: .default))
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    //Se llamara cuando obtengamos la captura del qr y procesemos el qr
    func foundTextFromQR(stringText:String) {
        print(stringText)
        // Serializacion
        if let data = stringText.data(using: .utf8) {
            let decoder = JSONDecoder()
            guard let device = try? decoder.decode(Dispensador.self, from: data) else { fatalError("Error en la serializacion") }
            
            //Alert
            let ac = UIAlertController(title: "Ingrese un nombre", message: nil, preferredStyle: .alert)
            ac.addTextField()
            let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
                let answer = ac.textFields![0]
                if !answer.text!.isEmpty{
                    AF.request(App.shared.API+"usuarios/vincular", method: .post, parameters: ["token": App.shared.token, "nombre": answer.text!, "codigo": device.data!]).responseData{ (response) in
                        do {
                            self.navigationController?.popToRootViewController(animated: true)
                            print(response.response)
                            
                        }catch {
                            print("Error en la serializacion \(error):")
                            //vc.alertDefault(with: "Error", andWithMsg: "Error en tus credenciales")
                        }
                    }
                }else{
                    self.alertDefault(with: "Campo vacio", andWithMsg: "Ingrese un nombre valido")
                }
            }

            ac.addAction(submitAction)

            present(ac, animated: true)
        }else {
            print("Error string to data")
        }
        
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            foundTextFromQR(stringText: stringValue)
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
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
