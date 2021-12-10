//
//  ActivityRecordViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 02/12/21.
//

import UIKit

class ActivityRecordViewCell: UITableViewCell {
    @IBOutlet weak var tableActivityRecord: UITableView!

    
    var heigOfHeader: CGFloat = 25
    var recordActivityList : [ResponseRecord] = []
    var section:Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableActivityRecord.dataSource = self
        tableActivityRecord.delegate = self
        tableActivityRecord.register(UINib(nibName: "ResumeCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ResumeCellTableViewCell")
        tableActivityRecord.separatorStyle = .none
        setupView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupView(){
        tableActivityRecord.layer.cornerRadius = 4
        tableActivityRecord.layer.borderColor = UIColor.init(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        tableActivityRecord.layer.shadowColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08).cgColor
        tableActivityRecord.layer.borderWidth = 1
        
        tableActivityRecord.layer.shadowColor = UIColor.black.cgColor
        tableActivityRecord.layer.shadowOpacity = 0.3
        tableActivityRecord.layer.shadowOffset = .zero
        tableActivityRecord.layer.shadowRadius = 3
        tableActivityRecord.layer.cornerRadius = 4
        
        tableActivityRecord.layer.shouldRasterize = true
        tableActivityRecord.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
}
extension ActivityRecordViewCell:UITableViewDataSource, UITableViewDelegate{
    //header
    func numberOfSections(in tableView: UITableView) -> Int {
        print(recordActivityList.count)
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heigOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("HeaderResumeTableViewCell", owner: self, options: nil)?.first as! HeaderResumeTableViewCell
        headerCell.lebelProjectName.text = recordActivityList[section].project.client.name
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recordActivityList[section].project.client.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recordActivityList[section].activityRecords.count)
        return recordActivityList[section].activityRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableActivityRecord.dequeueReusableCell(withIdentifier: "ResumeCellTableViewCell", for: indexPath) as! ResumeCellTableViewCell
        
        cell.selectionStyle = .none
        cell.labelNameActivity.text = recordActivityList[indexPath.section].activityRecords[indexPath.row].activity.name
        
        cell.labeDurationActivity.text = "\(recordActivityList[indexPath.section].activityRecords[indexPath.row].duration) hrs"
        
        return cell
    }
}
