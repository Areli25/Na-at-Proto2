//
//  MainTabViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import UIKit

class MainTabViewController: UITabBarController {
    var loginController:LoginViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 1
    }
}
