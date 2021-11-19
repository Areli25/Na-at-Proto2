//
//  NotificationsViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 10/11/21.
//

import Foundation
import UIKit

class NotificationsViewController:GenericViewController {
    @IBOutlet weak var headerView: ContentHeaders!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.goBack.isHidden = true
    }
}

