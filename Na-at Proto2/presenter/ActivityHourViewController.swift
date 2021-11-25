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
    var activityRecord:ActivityHourShow!
    var activityHourList:[ActivityHour] = []
    var idClient = ""
    var nameClient = ""
    var idProject = ""
    var projectName = ""
    var recordClient:ClientShow!
    var recordActivity:Activity!
    var recordProject:ProjectShow!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //inicializacion de la lista
        recordClient = ClientShow(id: idClient, name: nameClient)
        recordProject = ProjectShow(id: idProject, name: projectName)
        activityRecord = ActivityHourShow(client: recordClient, project: recordProject, activity: [Activity]())
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableActivityHour.register(UINib(nibName: "CellActivitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivitiesTableViewCell")
        tableActivityHour.delegate = self
        tableActivityHour.dataSource = self
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
    
    @IBAction func goToResumeScreen(_ sender: Any) {
        goToResumeScreen()
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
    func goToResumeScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let activityResumeViewController = storyboard.instantiateViewController(withIdentifier: "resumeActivityViewController") as! ResumeActivityViewController
        //agregamos los datos recabados a lista que usaremos para pintar la pnatalla de resumen
        GlobalParameters.shared.listProjects.append(activityRecord)
        //print(GlobalParameters.shared.listProjects)
        
        self.navigationController?.pushViewController(activityResumeViewController, animated: true)
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
    func addHours(nameActivity:String, duration:Int) {
        totalHours = totalHours + 1
        labelTotalHours.text = "\(totalHours) hrs"

        print(duration)
        if duration == 1{
            recordActivity = Activity(name: nameActivity, duration: 1)
            activityRecord.activity.append(recordActivity)
        }else{
            //actualizar duracion
            var index = 0
            for activityName in activityRecord.activity{
                if activityName.name == nameActivity{
                    activityRecord.activity[index].duration = duration
                    print(duration)
                }
                index += 1
            }
            print("actualizarbduracion")
        }
        tableActivityHour.reloadData()
    }
    
    
    func lessHours(nameActivity:String, duration:Int) {
        totalHours = totalHours - 1
        labelTotalHours.text = "\(totalHours) hrs"
        
        if duration == 0{
            //remover actividad
            var index = 0
            for activityName in activityRecord.activity{
                if activityName.name == nameActivity{
                    activityRecord.activity.remove(at: index)
                }
                index += 1
            }
            print("Remove")
        } else {
            //Si la duracion no es cero, actualizar la duración
            var index = 0
            for activityName in activityRecord.activity{
                if activityName.name == nameActivity{
                    activityRecord.activity[index].duration = duration
                    print(duration)
                }
                index += 1
        }
        tableActivityHour.reloadData()
    }
  }
}


