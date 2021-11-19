//
//  CustomCellProjectsTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 12/11/21.
//

import UIKit

class CellActivitiesTableViewCell: UITableViewCell {
    @IBOutlet weak var labelNameActivity: UILabel!
    @IBOutlet weak var btnLess: UIButton!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var activityView: UIView!
   // var delegateButton:Hours
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        setupButtonLess()
        //setupButtonAdd()
            
    }
    func setupView(){
        activityView.layer.cornerRadius = 8
        activityView.layer.borderColor = UIColor.init(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        activityView.layer.borderWidth = 1
    }
    func setupButtonLess(){
        btnLess.tintColor = UIColor.gray
        
    }
    func setupButtonAdd(){
        btnAdd.tintColor = UIColor.init(named: "salmon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addHours(_ sender: Any) {
        if count < 8{
            count += 1
            labelHours.text = "\(count) hrs"
      }
    }
    @IBAction func lessHours(_ sender: Any) {
        if count > 0{
            count -= 1
            
            labelHours.text = "\(count) hrs"
        }
    }
}
