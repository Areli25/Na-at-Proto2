//
//  ActivityHourViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 12/11/21.
//

import UIKit

class ActivityHourViewController: GenericViewController, HeaderProtocol{

    @IBOutlet weak var tableActivityHour: UITableView!
    @IBOutlet weak var headerView: ContentHeaders!
    var activityHour:ActivityHour?
    var activityHourList:[ActivityHour] = []
    var idActivity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegateGoBack = self
        tableActivityHour.register(UINib(nibName: "CellActivitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivitiesTableViewCell")
        tableActivityHour.delegate = self
        tableActivityHour.dataSource = self
        tableActivityHour.separatorStyle = .none
        getAllActivities()
    }
    
    func getAllActivities(){
        Service.shared.getActivitiesList(completion: { [self]
            res in
            switch res {
            case .success(let decodedData):
                print(decodedData)
                
                DispatchQueue.main.async {
                    for item in decodedData {
                        
                        print(decodedData)
                        activityHourList.append(item)
                    }
                    self.tableActivityHour.reloadData()
                }
                
            case .failure(let err):
                    print("Error en la petición: ", err)
                DispatchQueue.main.async {
                        activityHourList.removeAll()
                        tableActivityHour.reloadData()
                }
            }
        })
    }
}
extension ActivityHourViewController:UITableViewDelegate{
    
    
}
extension ActivityHourViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityHourList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableActivityHour.dequeueReusableCell(withIdentifier: "CellActivitiesTableViewCell", for: indexPath) as! CellActivitiesTableViewCell
        let activity:ActivityHour
        activity = activityHourList[indexPath.row]
        cell.labelNameActivity.text = activity.name
        
        return cell
    }
    
    func goBack() {
        super.goToBack()
    }
}


