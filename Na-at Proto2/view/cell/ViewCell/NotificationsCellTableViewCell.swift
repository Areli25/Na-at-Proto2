//
//  NotificationsCellTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 25/11/21.
//

import UIKit

class NotificationsCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitleNotification: UILabel!
    @IBOutlet weak var labelPriorityNotification: UILabel!
    @IBOutlet weak var labelDateNotification: UILabel!
    @IBOutlet weak var labelBodyNotification: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
