//
//  ActivityRecordViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 02/12/21.
//

import UIKit

class ActivityRecordViewCell: UITableViewCell {
    @IBOutlet weak var tableActivityRecord: UITableView!
    var heigOfHeader: CGFloat = 44
    var recordActivityList : [ResponseRecord] = []
    var section:Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableActivityRecord.dataSource = self
        tableActivityRecord.register(UINib(nibName: "CellActivityResumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivityResumeTableViewCell")
        tableActivityRecord.register(UINib(nibName: "ProjectsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectsTableViewCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension ActivityRecordViewCell:UITableViewDataSource{
    //header
    func numberOfSections(in tableView: UITableView) -> Int {
        print(recordActivityList.count)
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heigOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableActivityRecord.dequeueReusableCell(withIdentifier: "ProjectsTableViewCell") as! ProjectsTableViewCell
        headerCell.labelNameClient.text = recordActivityList[section].project.client.name
        
        return headerCell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "😅\(recordActivityList[section].project.client.name)😅"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(recordActivityList[section].activityRecords.count)
        return recordActivityList[section].activityRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableActivityRecord.dequeueReusableCell(withIdentifier: "CellActivityResumeTableViewCell", for: indexPath) as! CellActivityResumeTableViewCell
        
        cell.labelActivityName.text = recordActivityList[indexPath.section].activityRecords[indexPath.row].activity.name
        
        cell.labelActivityHours.text = "\(recordActivityList[indexPath.section].activityRecords[indexPath.row].duration) hrs"
        
        return cell
    }
}
