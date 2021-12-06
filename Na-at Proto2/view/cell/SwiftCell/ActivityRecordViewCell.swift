//
//  ActivityRecordViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 02/12/21.
//

import UIKit

class ActivityRecordViewCell: UITableViewCell {
    @IBOutlet weak var tableActivityRecord: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension ActivityRecordViewCell:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
