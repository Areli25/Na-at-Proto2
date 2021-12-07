//
//  ContentHeaders.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import UIKit

class ContentHeaders: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var ivPerfil: UIImageView!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var btnCerrarSesion: UIButton!
    @IBOutlet weak var labelUserName: UILabel!
    var delegateGoBack:HeaderProtocol!
    var delegateSesion:SignOutProtocol!
    
    let labelAttributes: [NSAttributedString.Key: Any] = [
         .font: UIFont.systemFont(ofSize: 15),
         .foregroundColor: UIColor.white,
         .underlineStyle: NSUnderlineStyle.single.rawValue
     ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        //setupImageView()
    }
       
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setupImageView()
    }
    
    
   private func setupImageView() {
    
        if let imageProfile = UserDefaults.standard.url(forKey: GlobalParameters.shared.keyUserProfile){
            ivPerfil.downloaded(from: imageProfile)
            ivPerfil.layer.cornerRadius = ivPerfil.bounds.height / 2
        }else{
            ivPerfil.image = UIImage(named: "mujer")
            ivPerfil.layer.cornerRadius = ivPerfil.bounds.height / 2
        }
    
    }
    @IBAction func goBack(_ sender: Any) {
        delegateGoBack?.goBack()
    }
    @IBAction func signOut(_ sender: Any) {
        delegateSesion?.signOut()
    }
    
    func commonInit (){
        let nib = UINib(nibName: "ContentHeaders", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        backgroundColor = .clear
        contentView.frame = bounds
        addSubview(contentView)
        
        let layer = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 100))
        let gradient = CAGradientLayer()
        gradient.frame = contentView.frame
        gradient.colors = [
          UIColor(red:1, green:0.51, blue:0.33, alpha:1).cgColor,
          UIColor(red:1, green:0.27, blue:0.52, alpha:1).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: -0.11)
        gradient.endPoint = CGPoint(x: 0.99, y: 1.11)
        layer.layer.addSublayer(gradient)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = contentView.frame
        rectShape.position = contentView.center
        rectShape.path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath

        layer.layer.mask = rectShape
        
        self.contentView.addSubview(layer)
        self.contentView.sendSubviewToBack(layer)
        
        let attributeString = NSMutableAttributedString(
                string: "Cerrar Sesión",
                attributes: labelAttributes
             )
             btnCerrarSesion.setAttributedTitle(attributeString, for: .normal)
        
        if let userName = UserDefaults.standard.string(forKey: GlobalParameters.shared.keyUserName){
            labelUserName.font = UIFont(name: "Europa-Bold", size: 18.0)
            labelUserName.text = " Hola, \(userName)"
        }
    }
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.ivPerfil.image = UIImage(data: data)
            }
        }
    }
}
protocol HeaderProtocol {
    func goBack()
}
protocol SignOutProtocol {
    func signOut()
}



