//
//  SecondHeaderView.swift
//  Na-at Proto2
//
//  Created by mpacheco on 23/11/21.
//

import UIKit

class SecondHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var contentViewDate: UIView!
    @IBOutlet weak var contentViewProject: UIView!
    @IBOutlet weak var btnChangeProject: UIButton!
    @IBOutlet weak var labelNameProject: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    var delegateSecondHeader: SecondHeaderProtocol?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initContentviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentviews()
    }
    
    func initContentviews() {
        let nib = UINib(nibName: "SecondHeaderView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
                
        backgroundColor = .clear
        
        contentView.frame = bounds
        addSubview(contentView)
        
        setRoundCornersBottomView(view: contentViewDate)
        setRoundCornersBottomView(view: contentViewProject)
    }
    private func setRoundCornersBottomView(view: UIView) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath

        view.layer.mask = rectShape
    }

    @IBAction func changeProject(_ sender: Any) {
        delegateSecondHeader?.goChangeProject()
    }
}
protocol SecondHeaderProtocol {
    func goChangeProject()
}
