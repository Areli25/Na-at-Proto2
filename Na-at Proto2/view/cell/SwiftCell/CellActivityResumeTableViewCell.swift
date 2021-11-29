//
//  CellActivityResumeTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 18/11/21.
//

import UIKit

class CellActivityResumeTableViewCell: UITableViewCell {
    @IBOutlet weak var labelActivityName: UILabel!
    @IBOutlet weak var labelActivityHours: UILabel!
    var cellIndex:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
