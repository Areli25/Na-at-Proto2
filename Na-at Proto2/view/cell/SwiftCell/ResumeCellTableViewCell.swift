//
//  ResumeCellTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/12/21.
//

import UIKit

class ResumeCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelNameActivity: UILabel!
    @IBOutlet weak var labeDurationActivity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
