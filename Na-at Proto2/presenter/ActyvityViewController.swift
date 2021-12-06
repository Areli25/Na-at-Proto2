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
    var responseRecordList:[ResponseRecord]?
    var heigOfHeader: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.goBack.isHidden = true
        setupButtonRegisterHours()
        tableRecordActivity.register(UINib(nibName: "ActivityRecordViewCell", bundle: nil), forCellReuseIdentifier: "ActivityRecordViewCell")
        tableRecordActivity.delegate = self
        tableRecordActivity.dataSource = self
    }
    
    func loadResponseRecordList(){
        
    }
    
    func setupButtonRegisterHours(){
        btnRegisterHours.layer.cornerRadius = 4
        btnRegisterHours.layer.borderColor = UIColor.init(red: 255/255, green: 101/255, blue: 108/255, alpha: 1).cgColor
        btnRegisterHours.layer.borderWidth = 2
    }
    
    @IBAction func getClients(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let clientsViewController = storyboard.instantiateViewController(withIdentifier: "getClientsViewController") as! ClientsViewController
        clientsViewController.getAllClients()
        self.navigationController?.pushViewController(clientsViewController, animated: true)
    }
}
extension ActivityViewController:UITableViewDelegate{
    
}
extension ActivityViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return responseRecordList?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heigOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("HeaderActivityRecordViewCell", owner: self, options: nil)?.first as! HeaderActivityRecordViewCell
        //asignacion de nombre del proyecto
        headerCell.labelDate.text = responseRecordList![section].activityRecords[0].date
        
        return headerCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseRecordList![section].activityRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("no code")
        
        let cell = self.tableRecordActivity.dequeueReusableCell(withIdentifier: "ActivityRecordViewCell", for: indexPath) as! ActivityRecordViewCell
        return cell
    }
}
//Thread 1: Fatal error: Index out of range
