//
//  NotificationsViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 10/11/21.
//

import Foundation
import UIKit

class NotificationsViewController:GenericViewController {
    @IBOutlet weak var notificationsTable: UITableView!
    @IBOutlet weak var headerView: ContentHeaders!
    var notificationsList:[NotificationStructure] = []
    var heigOfCell: CGFloat = 72
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerView.goBack.isHidden = true
        var notification = NotificationStructure(title: "Actividad creada", date: "20/11/2021", body: "Se ha agregado actividad 1", priority: 2)
        var news = NotificationStructure(title: "Noticia", date: "20/11/2021", body: "Tenemos noticias nuevas", priority: 1)
        var newActivity = NotificationStructure(title: "Actividad creada", date: "20/11/2021", body: "Se ha agregado actividad 1", priority: 2)
        notificationsList.append(notification)
        notificationsList.append(news)
        notificationsList.append(newActivity)
        notificationsTable.register(UINib(nibName: "NotificationsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationsCellTableViewCell")
        notificationsTable.delegate = self
        notificationsTable.dataSource = self
    }
}

extension NotificationsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heigOfCell
    }
}

extension NotificationsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationsTable.dequeueReusableCell(withIdentifier: "NotificationsCellTableViewCell", for: indexPath) as! NotificationsCellTableViewCell
        
        cell.labelTitleNotification.text = notificationsList[indexPath.row].title
        cell.labelDateNotification.text = notificationsList[indexPath.row].date
        cell.labelBodyNotification.text = notificationsList[indexPath.row].body
        var priority = notificationsList[indexPath.row].priority
        
        if priority == 1{
            cell.labelPriorityNotification.backgroundColor = notifications_color
        }else{
            cell.labelPriorityNotification.backgroundColor = green_notifications
        }
               
        return cell
    }
    
    
}

