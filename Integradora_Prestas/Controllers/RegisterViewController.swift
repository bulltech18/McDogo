//
//  RegisterViewController.swift
//  Integradora_Prestas
//
//  Created by GalaGa Apps on 26/03/21.
//  Copyright © 2021 Mac10. All rights reserved.
//

import UIKit

class RegisterViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
   
    

    var myControllers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = RegFirstViewController()
        myControllers.append(vc)
        let vc2 = RegTwoViewController()
        myControllers.append(vc2)

        
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.presentPageVC()
        })
    }
    func presentPageVC(){
        guard let first = myControllers.first else{
            return
        }
        let vc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        present(vc, animated: true)
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else{
            return nil
        }
        let before = index - 1
        return myControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count - 1) else{
            return nil
        }
        let after = index + 1
        return myControllers[after]
        
    }
    
}

