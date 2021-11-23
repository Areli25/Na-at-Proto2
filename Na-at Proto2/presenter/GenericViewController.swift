//
//  GenericViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 16/11/21.
//

import UIKit

class GenericViewController: UIViewController, SignOutProtocol {
    
    var totalHours = 0
    var count  = 0
    var isEnabled = true
    let salmon = UIColor(red: 255.0/255.0, green: 101.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        let end_gradient = UIColor(red: 255.0/255.0, green: 68.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        let first_gradient = UIColor(red: 255.0/255.0, green: 131.0/255.0, blue: 85.0/255.0, alpha: 1.0)

 

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public func goToRootViewController() {
        for vc in self.navigationController!.viewControllers {
            if vc.isKind(of: ViewController.self) {
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    public func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func goLogin(){
        (self.tabBarController as! MainTabViewController).loginController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func signOut() {
        (self.tabBarController as! MainTabViewController).loginController?.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension UIView {
   func applyGradient(colours: [UIColor]) -> Void {
       self.applyGradient(colours: colours, locations: nil)
   }

   func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
       let gradient: CAGradientLayer = CAGradientLayer()
       gradient.frame = self.bounds
       gradient.colors = colours.map { $0.cgColor }
       gradient.startPoint = CGPoint.zero
       gradient.endPoint = CGPoint(x: 1, y: 1)
       gradient.locations = locations
       self.layer.insertSublayer(gradient, at: 0)
   }
}

