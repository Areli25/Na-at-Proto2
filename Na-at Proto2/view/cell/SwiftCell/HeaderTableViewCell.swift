//
//  HeaderTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 17/11/21.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnModify: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
