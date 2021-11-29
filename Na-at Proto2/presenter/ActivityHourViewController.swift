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
        setupActivityRecordList()
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableActivityHour.register(UINib(nibName: "CellActivitiesTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivitiesTableViewCell")
        tableActivityHour.delegate = self
        tableActivityHour.dataSource = self
        btnRegister.isHidden = true
        setupButton()
        //getAllActivities()
    }

    func setupActivityRecordList(_ activityList: [Activity]? = [Activity]()){
        //recordClient =  ClientShow(id: idClient, name: nameClient)
        //recordProject = ProjectShow(id: idProject, name: projectName)
        
        activityRecord = GlobalParameters.shared.listProjects
        activityRecord.client.project[getProject(idProject)].activity = activityList!
        
        //activityRecord = ActivityHourShow(client: recordClient, project: recordProject, activity: activityList!)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllActivities()
        print("ESTOY DE REGRESO")
        
        
    }
    
    func setupScreenModify(item: ActivityHour) -> ActivityHour {
        for lista in GlobalParameters.shared.listProjects!.client.project {
            
            for activity in lista.activity {
                if activity.name == item.name {
                    return ActivityHour(id: item.id, name: item.name, duration: activity.duration)
                }
            }
        }
        return ActivityHour(id: item.id, name: item.name, duration: 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityHourList.removeAll()
        activityRecord.client.project[getProject(idProject)].activity.removeAll()
        tableActivityHour.reloadData()
        print("ADIOS")
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
                        
                        var newItem = ActivityHour(id: item.id, name: item.name, duration: 0)
                        newItem = self.setupScreenModify(item: newItem)
                        
                        
                        activityHourList.append(newItem)
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
        activityResumeViewController.projectName = projectName
        activityResumeViewController.idProject = idProject
        activityResumeViewController.vcActivityModify = self
        //agregamos los datos recabados a lista que usaremos para pintar la pnatalla de resumen
        
        var newList = [Activity]()
        
        for item in activityHourList {
            let newItem = Activity(name: item.name, duration: item.duration ?? 0)
            
            if newItem.duration > 0 {
                newList.append(newItem)
            }
        }
        
        var flagExiste = false
        var index = 0
        for project in GlobalParameters.shared.listProjects!.client.project {
            
            if project.name == activityRecord.client.project[index].name {
                    
                    flagExiste = true
                    break
                }
                index += 1
            
            
        }
        
        if flagExiste {
            activityRecord.client.project[getProject(idProject)].activity = newList
            //GlobalParameters.shared.listProjects?.client.project[getProject(idProject)].activity.remove(at: index)
            GlobalParameters.shared.listProjects?.client.project[index].activity = newList
                
                //.append(activityRecord.client.project[getProject()].activity)
        }
        else {
            GlobalParameters.shared.listProjects?.client.project[getProject(idProject)].activity = newList
        }
        
        activityResumeViewController.totalHoursProject = totalHours
        print("El total de horas al llegar a resumen de actividad es:\(totalHours)")
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
        cell.index = indexPath.row
        cell.labelHours.text = "\(activity.duration!) hrs"
        cell.count = activity.duration!
        
        /*if activityRecord.activity.count != 0 {
            for _activity in activityRecord.activity {
                if _activity.name == activity.name{
                    cell.labelHours.text =  "\(_activity.duration) hrs"
                    cell.count = _activity.duration
                }else{
                    
                }
            }
        }*/
        
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
    func addHours(nameActivity:String, duration:Int, indexRow: Int) {
        totalHours = totalHours + 1
        labelTotalHours.text = "\(totalHours) hrs"

        print(duration)
        
        if duration == 1{
            recordActivity = Activity(name: nameActivity, duration: 1)
            activityRecord.client.project[getProject(idProject)].activity.append(recordActivity)
            activityHourList[indexRow].duration = duration
        }else{
            //actualizar duracion
            var index = 0
            for activityName in activityRecord.client.project[getProject(idProject)].activity{
                if activityName.name == nameActivity{
                    activityRecord.client.project[getProject(idProject)].activity[index].duration = duration
                    print(duration)
                    activityHourList[indexRow].duration = duration
                }
                index += 1
            }
            print("actualizar duracion")
        }
        tableActivityHour.reloadData()
    }
    
    
    func lessHours(nameActivity:String, duration:Int, indexRow: Int) {
        totalHours = totalHours - 1
        labelTotalHours.text = "\(totalHours) hrs"
        
        if duration == 0{
            //remover actividad
            var index = 0
            for activityName in activityRecord.client.project[getProject(idProject)].activity{
                if activityName.name == nameActivity{
                    activityRecord.client.project[getProject(idProject)].activity.remove(at: index)
                    activityHourList[indexRow].duration = duration
                }
                index += 1
            }
            print("Remove")
        } else {
            //Si la duracion no es cero, actualizar la duración
            var index = 0
            for activityName in activityRecord.client.project[getProject(idProject)].activity{
                if activityName.name == nameActivity{
                    activityRecord.client.project[getProject(idProject)].activity[index].duration = duration
                    print(duration)
                    activityHourList[indexRow].duration = duration
                }
                index += 1
        }
        tableActivityHour.reloadData()
    }
  }
}


