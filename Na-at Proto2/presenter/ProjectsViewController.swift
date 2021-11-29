//
//  ProjectsViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 12/11/21.
//

import UIKit

class ProjectsViewController: GenericViewController, HeaderProtocol {
 
    @IBOutlet weak var tableProjectsById: UITableView!
    @IBOutlet weak var headerView: ContentHeaders!
    
    var projects:Projects?
    var projectsList:[Projects] = []
    var idClient = ""
    var nameClient = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableProjectsById.register(UINib(nibName: "ProjectsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectsTableViewCell")
        tableProjectsById.dataSource = self
        tableProjectsById.delegate = self
        tableProjectsById.separatorStyle = .none
        getAllProjects()
    }
    
    func goBack() {
        super.goToBack()
    }
    
    func getAllProjects(){
        Service.shared.getProjectsById(id: idClient, completion: { [self]
            res in
            switch res {
            case .success(let decodedData):
                print(decodedData)
                
                DispatchQueue.main.async {
                    for item in decodedData {
                        
                        print(decodedData)
                        projectsList.append(item)
                    }
                    self.tableProjectsById.reloadData()
                }
                
            case .failure(let err):
                    print("Error en la petición: ", err)
                DispatchQueue.main.async {
                        projectsList.removeAll()
                    tableProjectsById.reloadData()
                }
                        
            }
        })
        
    }
    
    func goToActivityList(projectId:String, nameProject:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let activityHourViewController = storyboard.instantiateViewController(withIdentifier: "activityHourViewController") as! ActivityHourViewController
        activityHourViewController.idProject = projectId
        activityHourViewController.projectName = nameProject
        
        GlobalParameters.shared.listProjects = ActivityHourShow(client: ClientShow(id: idClient, name: nameClient, project: [ProjectShow(id: projectId, name: nameProject, activity: [Activity]())]))
            
            
        
        
        activityHourViewController.idClient = idClient
        activityHourViewController.nameClient = nameClient
        
        self.navigationController?.pushViewController(activityHourViewController, animated: true)
    }
}
extension ProjectsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idproject = projectsList[indexPath.row].id
        let projectName = projectsList[indexPath.row].name
        
        goToActivityList(projectId: idproject, nameProject: projectName)
    }
    
}
extension ProjectsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableProjectsById.dequeueReusableCell(withIdentifier: "ProjectsTableViewCell", for: indexPath) as! ProjectsTableViewCell
        let thisActivity:Projects!
        thisActivity = projectsList[indexPath.row]
        cell.labelNameClient.text = thisActivity.name
        return cell
    }  
}



