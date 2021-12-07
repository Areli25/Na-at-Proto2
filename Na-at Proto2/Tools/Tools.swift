//
//  Tools.swift
//  Na-at Proto2
//
//  Created by mpacheco on 03/12/21.
//

import Foundation
import  UIKit
import Network

func showErrorView(_ type:String, viewController:UIViewController){
    var dialog:ErrorsViewController!
    dialog = ErrorsViewController(nibName: "ErrorsViewController", bundle: nil)
    dialog.delegate = viewController.self as? ErrorsViewController
   // NetworkErrors
}

