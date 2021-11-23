//
//  ProjectsTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 12/11/21.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    @IBOutlet weak var labelNameClient: UILabel!
    @IBOutlet weak var viewClients: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
        
    }
    func setupView(){
        viewClients.layer.cornerRadius = 4
        viewClients.layer.borderColor = UIColor.init(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        viewClients.layer.borderWidth = 1
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
