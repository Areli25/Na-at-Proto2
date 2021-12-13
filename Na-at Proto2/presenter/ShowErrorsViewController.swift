//
//  ShowErrorsViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 10/12/21.
//

import UIKit

class ShowErrorsViewController: UIViewController {
    @IBOutlet weak var ivImageError: UIImageView!
    @IBOutlet weak var btnTryAgain: UIButton!
    @IBOutlet weak var labelError: UILabel!
    var delegateButtonTryAgain:TryAgain!
    var errorType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent(_errorType: errorType)

    }
    
    func setContent(_errorType: String){
        if errorType == "network"{
            ivImageError.image = UIImage(named: "error-conexion")
            labelError.text = "Error de conexion"
        }else{
            ivImageError.image = UIImage(named: "error")
            labelError.text = "Algo salió mal"
        }
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegateButtonTryAgain.tryAgain()
    }
    
}
protocol TryAgain {
    func tryAgain()
}
