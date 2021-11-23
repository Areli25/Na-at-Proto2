//
//  SplashViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 22/11/21.
//

import UIKit

class SplashViewController: GenericViewController{
    @IBOutlet var viewBackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    func setupView(){
        viewBackground.applyGradient(colours: [first_gradient,end_gradient])
    }
}
