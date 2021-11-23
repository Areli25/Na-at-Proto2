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
    var idProject = ""

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
        Service.shared.getProjectsById(id: idProject, completion: { [self]
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
    
    func goToActivityList(activityId:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let activityHourViewController = storyboard.instantiateViewController(withIdentifier: "activityHourViewController") as! ActivityHourViewController
        activityHourViewController.idActivity = activityId
        self.navigationController?.pushViewController(activityHourViewController, animated: true)
    }
}
extension ProjectsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idActivity = projectsList[indexPath.row].id
        goToActivityList(activityId: idActivity)
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



