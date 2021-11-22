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
    var count = 0
    var totalHours = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableActivityHour.register(UINib(nibName: "CellActivitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivitiesTableViewCell")
        tableActivityHour.delegate = self
        tableActivityHour.dataSource = self
        tableActivityHour.separatorStyle = .none
        setupLabelTotalHours()
        setupButton()
        getAllActivities()
    }
    func setupButton(){
        btnRegister.applyGradient(colours: [first_gradient,end_gradient])
    }
    func setupLabelTotalHours(){
        labelTotalHours.text = "Horas trabajadas en el proyecto "
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
    
    func updateStatusButton(){
        
    }
    
    func goBack() {
        super.goToBack()
    }
    
    func addHours() {
        if count < 8{
            count += 1
            //cell.labelHours.text = "\(count) hrs"
            totalHours = totalHours + count
      }
    }
    
    func lessHours() {
        if count > 0{
            count -= 1
            /*btnLess.tintColor = salmon
            labelHours.text = "\(count) hrs"*/
            totalHours = totalHours + count
        }
    }
}


