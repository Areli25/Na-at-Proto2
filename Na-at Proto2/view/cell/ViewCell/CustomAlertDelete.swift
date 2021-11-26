//
//  CustomAlertDelete.swift
//  Na-at Proto2
//
//  Created by mpacheco on 26/11/21.
//

import UIKit

class CustomAlertDelete: UIView{


    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var labelNameProject: UILabel!
    @IBOutlet weak var btnDeleteProject: UIButton!
    let first_gradient = UIColor(red: 255.0/255.0, green: 131.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    let end_gradient = UIColor(red: 255.0/255.0, green: 68.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    static let instance = CustomAlertDelete()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initContentviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomAlertDelete", owner: self, options: nil)
        initContentviews()
    }
    func setupButton(){
        btnDeleteProject.applyGradient(colours: [first_gradient, end_gradient])
        btnDeleteProject.layer.cornerRadius = 20;
        btnDeleteProject.layer.masksToBounds = true
    }
    
    func initContentviews() {
        contentView.frame = bounds
        addSubview(contentView)
        
        setRoundCornersBottomView(view: contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
              contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    private func setRoundCornersBottomView(view: UIView) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath

        view.layer.mask = rectShape
    }
    func showAlert(message: String) {
        self.labelNameProject.text = message
    }
}
