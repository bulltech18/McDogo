//
//  Extensiones.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 29/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

extension UIView{
    func roundView(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
    func roundBit(){
        self.layer.cornerRadius = bounds.height / 2
    }
}
extension UIButton {
    func round(){
        layer.cornerRadius = bounds.height / 2
    }
    
    func bounce(){
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (completion) in
            if completion {
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }

            }
        }

    }
    
    func jump() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(translationX: 0, y: -10)
        } completion: { (completado) in
            if completado {
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
            }
        }

    }
    
    func shine(){
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0.3
        } completion: { (c) in
            UIView.animate(withDuration: 0.2) {
                self.alpha = 1
            }
        }

    }
    
    func pulse(){
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (c) in
            UIView.animate(withDuration: 1) {
                self.transform = .identity
            } completion: { (c) in
                self.pulse()
            }
        }

    }
}
extension UIView{
    func shake(){
            self.transform = CGAffineTransform(translationX: 20, y: 0)
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
    }
}

extension UIViewController {
    func alertDefault(with title:String, andWithMsg description:String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(a) in alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
}
