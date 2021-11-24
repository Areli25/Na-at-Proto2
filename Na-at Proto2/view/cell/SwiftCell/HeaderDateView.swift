//
//  HeaderDateView.swift
//  Na-at Proto2
//
//  Created by mpacheco on 23/11/21.
//

import UIKit

class HeaderDateView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewDate: UIView!
    @IBOutlet weak var labelDate: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initContentviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentviews()
    }
    
    func initContentviews() {
        let nib = UINib(nibName: "HeaderDateView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        backgroundColor = .clear
        contentView.frame = bounds
        addSubview(contentView)
        setRoundCornersBottomView(view: contentViewDate)
    }
    private func setRoundCornersBottomView(view: UIView) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath

        view.layer.mask = rectShape
    }
    
}
