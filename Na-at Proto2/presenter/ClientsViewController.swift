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
    @IBOutlet weak var btnSearchClient: UIButton!
    @IBOutlet weak var searchClient: UISearchBar!
    @IBOutlet weak var labelClient: UILabel!
    
    var clientsList:[Client] = []
    var clientsListFilter:[Client] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchClient.delegate = self
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
        tableClients.register(UINib(nibName: "ProjectsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectsTableViewCell")
        tableClients.dataSource = self
        tableClients.delegate = self
        tableClients.separatorStyle = .none
        searchClient.isHidden = true
        self.searchClient.backgroundImage = UIImage()
    }
    
    @IBAction func searchClient(_ sender: Any) {
        searchClient.isHidden = false
        labelClient.isHidden = true
        btnSearchClient.isHidden = true
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
                    self.clientsListFilter = clientsList
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
        let idClient = clientsListFilter[indexPath.row].id
        let nameClient = clientsListFilter[indexPath.row].name
        goToProjectsList(clientId: idClient, clientName: nameClient )
    }  
}

extension ClientsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientsListFilter.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableClients.dequeueReusableCell(withIdentifier: "ProjectsTableViewCell", for: indexPath) as! ProjectsTableViewCell
        let thisActivity:Client!
        thisActivity = clientsListFilter[indexPath.row]
        cell.labelNameClient.text = thisActivity.name
        return cell
    }
    
    func goBack() {
        super.goToBack()
    }
}
extension ClientsViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     clientsListFilter = []
        
        if searchText == "" {
            clientsListFilter = clientsList
        }else{
            for clients in clientsList{
                if clients.name.lowercased().contains(searchText.lowercased()){
                    clientsListFilter.append(clients)
                }
            }
        }
        tableClients.reloadData()
    }
}
