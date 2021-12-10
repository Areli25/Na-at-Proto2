//
//  ActyvityViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 10/11/21.
//

import Foundation
import UIKit

class ActivityViewController: GenericViewController {
    @IBOutlet weak var btnRegisterHours: UIButton!
    @IBOutlet weak var headerView: ContentHeaders!
    @IBOutlet weak var tableRecordActivity: UITableView!
    var recordActivity:Record?
    var responseRecordList:[ResponseRecord] = []
    var heigOfHeader: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.goBack.isHidden = true
        setupButtonRegisterHours()
        tableRecordActivity.register(UINib(nibName: "ActivityRecordViewCell", bundle: nil), forCellReuseIdentifier: "ActivityRecordViewCell")
        tableRecordActivity.register(UINib(nibName: "HeaderActivityRecordViewCell", bundle: nil), forCellReuseIdentifier: "HeaderActivityRecordViewCell")
        tableRecordActivity.dataSource = self
        getActivityRecordList()
    }
    
    func setupButtonRegisterHours(){
        btnRegisterHours.layer.cornerRadius = 4
        btnRegisterHours.layer.borderColor = UIColor.init(red: 255/255, green: 101/255, blue: 108/255, alpha: 1).cgColor
        btnRegisterHours.layer.borderWidth = 2
    }
    
    
    func getActivityRecordList(){
        Service.shared.getActivityRecordList(completion: { [self]
            res in
            switch res {
            case .success(let decodedData):
                print(decodedData)
                
                DispatchQueue.main.async {
                    self.responseRecordList = decodedData
                    self.tableRecordActivity.reloadData()
                }
                
            case .failure(let err):
                    print("Error en la petición: ", err)
            }
        })
    }
    
    @IBAction func getClients(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let clientsViewController = storyboard.instantiateViewController(withIdentifier: "getClientsViewController") as! ClientsViewController
        clientsViewController.getAllClients()
        self.navigationController?.pushViewController(clientsViewController, animated: true)
    }
}


extension ActivityViewController:UITableViewDataSource{
     func numberOfSections(in tableView: UITableView) -> Int {
        return responseRecordList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        //asignacion de datos
        //headerCell.delegateButtons = self
        headerCell.index = section
        //asignacion de nombre del proyecto
        headerCell.projectName.text = "Asi funciona"
        
        return headerCell

    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "😅\(responseRecordList[section].activityRecords[0].date)😅"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableRecordActivity.dequeueReusableCell(withIdentifier: "ActivityRecordViewCell", for: indexPath) as! ActivityRecordViewCell
        
        cell.recordActivityList = responseRecordList
        cell.section = indexPath.section
        
        return cell
    }
}
