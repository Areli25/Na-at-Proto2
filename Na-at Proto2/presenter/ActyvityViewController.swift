//
//  ActyvityViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 10/11/21.
//

import Foundation
import UIKit

class ActivityViewController: GenericViewController {
    @IBOutlet weak var btnRegisterHours: UIButton!
    @IBOutlet weak var headerView: ContentHeaders!
    override func viewDidLoad() {
        super.viewDidLoad()
        //headerView.delegateGoBack = self
        self.headerView.goBack.isHidden = true
        setupButtonRegisterHours()
    }
    func setupButtonRegisterHours(){
        btnRegisterHours.layer.cornerRadius = 4
        btnRegisterHours.layer.borderColor = UIColor.init(red: 255/255, green: 101/255, blue: 108/255, alpha: 1).cgColor
        btnRegisterHours.layer.borderWidth = 2
    }
    
    @IBAction func getClients(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let clientsViewController = storyboard.instantiateViewController(withIdentifier: "getClientsViewController") as! ClientsViewController
        clientsViewController.getAllClients()
        self.navigationController?.pushViewController(clientsViewController, animated: true)
    }
}
