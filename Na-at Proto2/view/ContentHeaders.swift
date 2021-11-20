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
    var delegateGoBack:HeaderProtocol!
    var delegateSesion:SignOutProtocol!
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
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
    
   private func setupImageView(imageName: String = "mujer") {
        ivPerfil.image = UIImage(named: imageName)
        ivPerfil.layer.cornerRadius = ivPerfil.bounds.height / 2
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
                attributes: yourAttributes
             )
             btnCerrarSesion.setAttributedTitle(attributeString, for: .normal)
    }
}
protocol HeaderProtocol {
    func goBack()
}
protocol SignOutProtocol {
    func signOut()
}
