//
//  ViewControllerRoot.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import Foundation

import UIKit

class ViewControllerRoot: GenericViewController, CustomCell{
    
    @IBOutlet weak var viewHeader: ContentHeaders!
    @IBOutlet weak var tableNews: UITableView!
    private var newsData: NewsData?
    
    var newsList:[ObjetData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewHeader.goBack.isHidden = true
        tableNews.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        tableNews.delegate = self
        tableNews.dataSource = self
        tableNews.separatorStyle = .none
        getAllNews()
    }
    
    func getAllNews(){
        Service.shared.getListNews(completion: { [self]
            res in
            switch res {
            case .success(let decodedData):
                print(decodedData)
                
                DispatchQueue.main.async {
                    for item in decodedData {
                        print(decodedData)
                        newsList.append(item)
                        
                    }
                    self.tableNews.reloadData()
                }
                
            case .failure(let err):
                    print("Error en la petición: ", err)
                        newsList.removeAll()
                        tableNews.reloadData()
            }
        })
    }
}
extension ViewControllerRoot:UITableViewDelegate{
}
extension ViewControllerRoot:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableNews.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
               
        let thisActivity:ObjetData!
        
        thisActivity = newsList[indexPath.row]
        
        cell.labelTitleNews.text = thisActivity.headline
        cell.labelDateNews.text = thisActivity.creationDate
        cell.labelContentNews.text = thisActivity.body
        cell.ivImageNews.downloaded(from: thisActivity.image)
        cell.delegate = self
        cell.idNews = thisActivity.id
        return cell
    }
    
    func goNewsDetail(id: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let newsViewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        newsViewController.idNewsDetail = id
        newsViewController.getNewsDetail()
        self.navigationController?.pushViewController(newsViewController, animated: true)
    }
    
}

