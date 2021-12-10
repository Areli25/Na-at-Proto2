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
    var heigOfHeader: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.goBack.isHidden = true
        setupButtonRegisterHours()
        tableRecordActivity.register(UINib(nibName: "ActivityRecordViewCell", bundle: nil), forCellReuseIdentifier: "ActivityRecordViewCell")
        tableRecordActivity.delegate = self
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

extension ActivityViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return responseRecordList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heigOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("HeaderActivityRecordViewCell", owner: self, options: nil)?.first as! HeaderActivityRecordViewCell
        //asignacion de nombre del proyecto
        headerCell.labelDate.text = responseRecordList[section].activityRecords[0].date
        headerCell.labeltotalHours.text = "\(responseRecordList[section].activityRecords[0].duration) hrs"
        return headerCell
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
