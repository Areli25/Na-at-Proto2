//
//  ErrorsViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 03/12/21.
//

import UIKit

class ErrorsViewController: UIViewController {
    
    @IBOutlet weak var ivImageError: UIImageView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var btnTryAgain: UIButton!
    var delegateButtonTryAgain:TryAgain!
    var delegate:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        self.delegateButtonTryAgain.tryAgain()
    }
}
protocol TryAgain {
    func tryAgain()
}

