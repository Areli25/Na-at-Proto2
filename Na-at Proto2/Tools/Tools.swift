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

func formattedDate() -> String {
     let dateformatGet = DateFormatter()
     dateformatGet.dateFormat = "aaaa-MM-dd"
    
    let formatDateInProject = DateFormatter()
    formatDateInProject.dateFormat = "EEEE d MMM"
    
    let date = dateformatGet.date(from: "2021-12-10")!
    return formatDateInProject.string(from: date)
 }

