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
    var delegateButtons:DelegateButtonAction!
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func modyfyActivityRecord(_ sender: Any) {
        delegateButtons?.modifyActivityRecord()
    }
    @IBAction func deleteActivityRecord(_ sender: Any) {
        delegateButtons?.deleteActivityRecord()
    }
}
protocol DelegateButtonAction {
    func modifyActivityRecord()
    func deleteActivityRecord()
}
