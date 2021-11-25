//
//  ProjectsViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 12/11/21.
//

import Foundation

import UIKit

class ClientsViewController: GenericViewController, HeaderProtocol {
    

    @IBOutlet weak var tableClients: UITableView!
    @IBOutlet weak var headerView: ContentHeaders!
    
    var clientsList:[Client] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableClients.register(UINib(nibName: "ProjectsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectsTableViewCell")
        tableClients.dataSource = self
        tableClients.delegate = self
        tableClients.separatorStyle = .none
    }
    
    func getAllClients(){
        Service.shared.getClients(completion: { [self]
            res in
            switch res {
            case .success(let decodedData):
                print(decodedData)
                
                DispatchQueue.main.async {
                    for item in decodedData {
                        
                        print(decodedData)
                        clientsList.append(item)
                    }
                    self.tableClients.reloadData()
                }
            case .failure(let err):
                    print("Error en la petición: ", err)
                DispatchQueue.main.async {
                        clientsList.removeAll()
                        tableClients.reloadData()
                }
            }
        })
    }
    
    func goToProjectsList(clientId:String, clientName:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let projectsViewController = storyboard.instantiateViewController(withIdentifier: "porjectsViewController") as! ProjectsViewController
        projectsViewController.idClient = clientId
        projectsViewController.nameClient = clientName
        self.navigationController?.pushViewController(projectsViewController, animated: true)
    }
}

extension ClientsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idClient = clientsList[indexPath.row].id
        let nameClient = clientsList[indexPath.row].name
        goToProjectsList(clientId: idClient, clientName: nameClient )
    }  
}

extension ClientsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableClients.dequeueReusableCell(withIdentifier: "ProjectsTableViewCell", for: indexPath) as! ProjectsTableViewCell
        let thisActivity:Client!
        thisActivity = clientsList[indexPath.row]
        cell.labelNameClient.text = thisActivity.name
        return cell
    }
    
    func goBack() {
        super.goToBack()
    }
}
