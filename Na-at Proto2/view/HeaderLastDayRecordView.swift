//
//  HeaderLastDayRecordView.swift
//  Na-at Proto2
//
//  Created by mpacheco on 08/12/21.
//

import UIKit

class HeaderLastDayRecordView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var labelDaysSinceLastRecord: UILabel!
    @IBOutlet weak var btnRecorHours: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setupButtonRegister(){
        btnRecorHours.layer.borderWidth = 1.0
        btnRecorHours.layer.borderColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        btnRecorHours.layer.cornerRadius = 5.0
    }
    
    func commonInit (){
        let nib = UINib(nibName: "HeaderLastDayRecordView", bundle: nil)
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
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        layer.layer.addSublayer(gradient)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = contentView.frame
        rectShape.position = contentView.center
        rectShape.path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
        
        layer.layer.mask = rectShape
        
        self.contentView.addSubview(layer)
        self.contentView.sendSubviewToBack(layer)
        
        setupButtonRegister()
        
    }
}
