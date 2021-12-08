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
    var nameUser = ""
    var userProfile:URL!
    var gidConfigure:GIDConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NetworkMonitor.shared.isConnected{
            if GIDSignIn.sharedInstance.hasPreviousSignIn() {
                self.performSegue(withIdentifier: "goNews", sender: nil)
            }
        }else{
            print("Error")
        }
        setupButton()
        btnLogin.layer.cornerRadius = 20;
        btnLogin.layer.masksToBounds = true;
        gidConfigure = GIDConfiguration.init(clientID: "172083403533-bq0mfp199apgm4s70m8t3hdrsp32jr8e.apps.googleusercontent.com")
    }
    
    func setupButton(){
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 20
        btnLogin.applyGradient(colours: [first_gradient,end_gradient])
        
    }
    func setupLabel(){
        labelTeminos.textColor = UIColor(named: "Salmon")
        labelContinuar.textColor = UIColor(named: "gray_9B9B9B")
    }
    
    @IBAction func goNews(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: gidConfigure!, presenting: self, callback: {
            user, err in
            guard let user = user else { return }
            
            let email = user.profile?.email
            
            if email!.contains("@na-at.com.mx"){
                self.performSegue(withIdentifier: "goNews", sender: nil)
                UserDefaults.standard.setValue("\(user.profile!.name)", forKey: GlobalParameters.shared.keyUserName)
                UserDefaults.standard.set(user.profile!.imageURL(withDimension: 40)!, forKey: GlobalParameters.shared.keyUserProfile)
                print( UserDefaults.standard.setValue("\(user.profile!.name)", forKey: GlobalParameters.shared.keyUserName))
                print(UserDefaults.standard.set(user.profile!.imageURL(withDimension: 40)!, forKey: GlobalParameters.shared.keyUserProfile))
               
            }else{
                self.showModal()
            }
        })
    }
    func showModal(){
        
        let baner = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        baner.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        let card = UIView(frame: CGRect(x: 0, y: 0, width: 286, height: 299))
        card.layer.cornerRadius = 10
        
        let imClose = UIImage(named: "cerrar")
        let button = ButtonDeleteProject(frame: CGRect(x: 255, y: 10, width: 20, height: 20))
        button.setImage(imClose, for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(closeDialog(_:)), for: .touchUpInside)
        
        let imgLogo = UIImage(named: "Nsquare")
        let imgViewLogo = UIImageView(frame: CGRect(x: 110, y: 50, width: 60, height: 60))
        imgViewLogo.image = imgLogo
        //35
        let lbtitle = UILabel(frame: CGRect(x: 22, y: 110, width: 236, height: 40))
        lbtitle.text = "Únete con tu cuenta NA-AT"
        lbtitle.font = UIFont.init(name: "Nunito-SemiBold", size: 15)
        lbtitle.textAlignment = .center
        lbtitle.numberOfLines = 0
        
        let lbContent = UILabel(frame: CGRect(x: 20, y: 130, width: 250, height: 160))
        lbContent.lineBreakMode = .byWordWrapping
        lbContent.textAlignment = .center
        lbContent.numberOfLines = 4
        lbContent.text = "El acceso a la aplicación solo esta disponible para talento NAAT Ingresa con tu correo @na-at.com.mx"
        lbContent.font = UIFont.init(name: "Nunito-SemiBold", size: 15)
         
        //card content
        card.addSubview(imgViewLogo)
        card.addSubview(lbContent)
        card.addSubview(lbtitle)
        card.addSubview(button)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        
        baner.tag = 100
        baner.addSubview(card)
        view.addSubview(baner)
        
        card.center = baner.convert(baner.center, from:baner.superview)
    }
    @objc func closeDialog(_ sender: Any){
        deleteDialog()
    }
    
    func deleteDialog(){
        if let myView = self.view.viewWithTag(100){
            myView.willMove(toWindow: nil)
            myView.removeFromSuperview()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goNews"{
            let viewController = segue.destination as! MainTabViewController
            viewController.loginController = self
        }
    }
}

