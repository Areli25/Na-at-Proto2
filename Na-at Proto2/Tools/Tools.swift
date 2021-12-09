//
//  Tools.swift
//  Na-at Proto2
//
//  Created by mpacheco on 03/12/21.
//

import Foundation
import  UIKit
import Network

class SpinnerViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

func showErrorView(_ type:String, viewController:UIViewController){
    var dialog:ErrorsViewController!
    dialog = ErrorsViewController(nibName: "ErrorsViewController", bundle: nil)
    dialog.delegate = viewController.self as? ErrorsViewController
   // NetworkErrors
}

