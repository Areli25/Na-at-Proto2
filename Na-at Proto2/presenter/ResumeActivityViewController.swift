//
//  ResumeActivityViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 17/11/21.
//

import UIKit

class ResumeActivityViewController: GenericViewController, HeaderProtocol, DelegateButtonAction {
    
    @IBOutlet weak var headerView: ContentHeaders!
    @IBOutlet weak var tableResumeActivity: UITableView!
    @IBOutlet weak var btnAddMoreHours: UIButton!
    @IBOutlet weak var btnRegisterHours: UIButton!
    var activityHourList:[ActivityHourShow] = []
    let buttonAttributes: [NSAttributedString.Key: Any] = [
         .font: UIFont.systemFont(ofSize: 15),
         .foregroundColor: UIColor.white,
         .underlineStyle: NSUnderlineStyle.single.rawValue
     ]
    var projectName = ""
    
    var heigOfHeader: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityHourList = GlobalParameters.shared.listProjects
        print(activityHourList)
        headerView.delegateSesion = self
        headerView.delegateGoBack = self
        tableResumeActivity.register(UINib(nibName: "CellActivityResumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivityResumeTableViewCell")
        headerView.delegateGoBack = self
        setupButtonn()
        tableResumeActivity.delegate = self
        tableResumeActivity.dataSource = self
    }
    
    func setupButtonn(){
        btnRegisterHours.applyGradient(colours: [first_gradient,end_gradient])
        btnRegisterHours.layer.cornerRadius = 20;
        btnRegisterHours.layer.masksToBounds = true;
        
    }
    
    func goBack() {
        super.goToBack()
    }
    
    func modifyActivityRecord() {
        super.goToBack()
        print("modify")
    }
    
    func deleteActivityRecord() {
        // create the alert
        let alert = UIAlertController(title: "", message: "¿Estas seguro de eliminar las horas del proyecto? Proyecto \(projectName)", preferredStyle: UIAlertController.Style.alert)

                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Si eliminar", style: UIAlertAction.Style.default, handler: nil))
                

                // show the alert
                self.present(alert, animated: true, completion: nil)
        print("delete")
    }
}
extension ResumeActivityViewController:UITableViewDelegate{
    
}

extension ResumeActivityViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activityHourList.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heigOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
         //asignacion de datos
        headerCell.delegateButtons = self
        headerCell.index = section
        //asignacion de nombre del proyecto
        headerCell.projectName.text = activityHourList[section].project.name
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityHourList[section].activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableResumeActivity.dequeueReusableCell(withIdentifier: "CellActivityResumeTableViewCell", for: indexPath) as! CellActivityResumeTableViewCell
        cell.labelActivityName.text = activityHourList[indexPath.section].activity[indexPath.row].name
        let duration = activityHourList[indexPath.section].activity[indexPath.row].duration
        
        if duration == 1{
            cell.labelActivityHours.text = "\(duration) hora"
            
        }else{
            cell.labelActivityHours.text = "\(duration) horas"
        }
        
        return cell
    }
}



