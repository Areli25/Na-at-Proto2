//
//  HeaderActivityRecordViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 03/12/21.
//

import UIKit

class HeaderActivityRecordViewCell: UITableViewCell {
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labeltotalHours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
