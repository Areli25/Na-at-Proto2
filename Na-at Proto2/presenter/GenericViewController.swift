//
//  GenericViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 16/11/21.
//

import UIKit

class GenericViewController: UIViewController {

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

}
