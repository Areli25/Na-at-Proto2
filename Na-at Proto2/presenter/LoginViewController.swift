//
//  LoginViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewController: GenericViewController {
    
    @IBOutlet weak var labelTeminos: UILabel!
    @IBOutlet weak var labelContinuar: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    var gidConfigure:GIDConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        setupButton()
        gidConfigure = GIDConfiguration.init(clientID: "172083403533-bq0mfp199apgm4s70m8t3hdrsp32jr8e.apps.googleusercontent.com")
 
    }
    
    func setupButton(){
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 20
        btnLogin.applyGradient(colours: [first_gradient,end_gradient])
        
    }
    func setupLabel(){
        labelTeminos.textColor = UIColor.init(named: "Salmon")
        //labelTeminos.font = UIFont(name: "NunitoRegular", size: 13)
        labelContinuar.textColor = UIColor.init(named: "gray_9B9B9B")
        //labelContinuar.font = UIFont(name: "NunitoRegular", size: 13)
    }
  
    @IBAction func goNews(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: gidConfigure!, presenting: self, callback: {
        user, err in
        guard let user = user else { return }
                           
        print("Email: ", user.profile?.imageURL(withDimension: 200) ?? "No email")
        print("Email: ", user.profile?.email ?? "No email")
            self.performSegue(withIdentifier: "goNews", sender: nil)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goNews"{
            let viewController = segue.destination as! MainTabViewController
            viewController.loginController = self
        }
    }
}

