//
//  ActivityHourViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 12/11/21.
//

import UIKit

class ActivityHourViewController: GenericViewController, HeaderProtocol, ActivityHourProtocol{
    

    @IBOutlet weak var labelTotalHours: UILabel!
    @IBOutlet weak var tableActivityHour: UITableView!
    @IBOutlet weak var headerView: ContentHeaders!
    @IBOutlet weak var btnRegister: UIButton!
    var activityHour:ActivityHour?
    var activityHourList:[ActivityHour] = []
    var idActivity = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableActivityHour.register(UINib(nibName: "CellActivitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivitiesTableViewCell")
        tableActivityHour.delegate = self
        tableActivityHour.dataSource = self
        setupLabelTotalHours()
        btnRegister.isHidden = true
        setupButton()
        getAllActivities()
    }
    func showButton(){
        if totalHours == 0{
            btnRegister.isHidden = true
        }else{
            btnRegister.isHidden = false
        }
    }
    func setupButton(){
        btnRegister.applyGradient(colours: [first_gradient,end_gradient])
        btnRegister.layer.cornerRadius = 20;
        btnRegister.layer.masksToBounds = true
    }
    func setupLabelTotalHours(){
        labelTotalHours.text = " Horas trabajadas en el proyecto "
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
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
        cell.delegateHours = self
        cell.totalHours = self.totalHours
        _ = cell.updateStatusButton(operation: false)
        
        if self.totalHours == 8{
            cell.disabledAddButton()
            showButton()
        }else if self.totalHours < 8{
            cell.enabledAddButton()
            showButton()
        }
        
        return cell
    }

    func goBack() {
        super.goToBack()
    }
    
    func addHours() {
        totalHours = totalHours + 1
        labelTotalHours.text = " Horas trabajadas en el proyecto: \(totalHours) hrs"
        tableActivityHour.reloadData()
    }
    
    func lessHours() {
        totalHours = totalHours - 1
        labelTotalHours.text = " Horas trabajadas en el proyecto: \(totalHours) hrs"
        tableActivityHour.reloadData()
    }
    
}


