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
    var index = 0
    
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
        let totalHoursProject = GlobalParameters.shared.totalHoursProjects + totalHours
        
        if totalHoursProject != 0 {
            if  count == 0{
                btnLess.isEnabled = false
                btnLess.tintColor = UIColor.gray
                return operation ? true : false
            }
            if totalHoursProject == 8 || count == 8{
                btnAdd.isEnabled = false
                btnAdd.tintColor = UIColor.gray
                return operation ? false: true
            }
            if (totalHoursProject > 0 && totalHoursProject < 8) &&  (count > 0 && count < 8) {
                btnLess.isEnabled = true
                btnLess.tintColor = salmon
                btnAdd.isEnabled = true
                btnAdd.tintColor = salmon
                return operation ? true : true
            }
            
        }else{
            
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
        print(count)
        let activityName = labelNameActivity.text ?? ""
        
        if updateStatusButton(operation:true){
            count += 1
            let durationActivity = count
            delegateHours?.addHours(nameActivity: activityName, duration: durationActivity, indexRow:index)
        labelHours.text = "\(count) hrs"
        }
        _ = updateStatusButton(operation: true)
    }

    @IBAction func lessHours(_ sender: Any) {
        let activityName = labelNameActivity.text ?? ""
        if updateStatusButton(operation:false){
            count -= 1
            let durationActivity = count

            delegateHours?.lessHours(nameActivity: activityName, duration: durationActivity, indexRow:index)
        labelHours.text = "\(count) hrs"
        }
        _ = updateStatusButton(operation: false)
    }
}
protocol ActivityHourProtocol {
    func addHours(nameActivity:String, duration:Int, indexRow: Int)
    func lessHours(nameActivity:String, duration:Int, indexRow: Int)
}
