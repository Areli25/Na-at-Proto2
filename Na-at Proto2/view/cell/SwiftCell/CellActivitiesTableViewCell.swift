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
    let salmon = UIColor(red: 255.0/255.0, green: 101.0/255.0, blue: 108.0/255.0, alpha: 1.0)
    @IBOutlet weak var activityView: UIView!
    var delegateHours:ActivityHourProtocol!
    var totalHours = 0
    var count = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtonLess()
    }
    
    func setupButtonLess(){
        btnLess.tintColor = UIColor.gray
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateStatusButton(operation:Bool) -> Bool{
        if count == 0{
            btnLess.isEnabled = false
            btnLess.tintColor = UIColor.gray
            return operation ? true : false
        }
        if count == 8{
            btnAdd.isEnabled = false
            btnAdd.tintColor = UIColor.gray
            return operation ? false: true
        }
        if count > 0 && count < 8{
            btnLess.isEnabled = true
            btnLess.tintColor = salmon
            btnAdd.isEnabled = true
            btnAdd.tintColor = salmon
            return operation ? true : true
        }
        return false
    }
    
    func enabledAddButton(){
        btnAdd.tintColor = salmon
        btnAdd.isEnabled = true
    }
    func enabledLessButton(){
        btnLess.tintColor = salmon
        btnLess.isEnabled = true
    }
    func disabledAddButton(){
        btnAdd.tintColor = UIColor.gray
        btnAdd.isEnabled = false
    }
    func disabledLessButton(){
        btnLess.tintColor = UIColor.gray
        btnLess.isEnabled = false
    }
    
    @IBAction func addHours(_ sender: Any) {
        if updateStatusButton(operation:true){
        delegateHours?.addHours()
        count += 1
        labelHours.text = "\(count) hrs"
        }
        _ = updateStatusButton(operation: true)
    }

    @IBAction func lessHours(_ sender: Any) {
        if updateStatusButton(operation:false){
        delegateHours?.lessHours()
        count -= 1
        labelHours.text = "\(count) hrs"
        }
        _ = updateStatusButton(operation: false)
    }
}
protocol ActivityHourProtocol {
    func addHours()
    func lessHours()
}
