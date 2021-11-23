//
//  ResumeActivityViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 17/11/21.
//

import UIKit
struct projectsName {
    var name:String
}

class ResumeActivityViewController: GenericViewController, HeaderProtocol {
    
    @IBOutlet weak var headerView: ContentHeaders!
    @IBOutlet weak var tableResumeActivity: UITableView!
    @IBOutlet weak var btnAddMoreHours: UIButton!
    @IBOutlet weak var btnRegisterHours: UIButton!
    let buttonAttributes: [NSAttributedString.Key: Any] = [
         .font: UIFont.systemFont(ofSize: 15),
         .foregroundColor: UIColor.white,
         .underlineStyle: NSUnderlineStyle.single.rawValue
     ]
    
    var heigOfHeader: CGFloat = 44
    var listProjectsName = ["uno","dos","tres"]
    var listActivitiesName = ["Activity 1","Activity 2","Activity 2","Activity 2","Activity 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegateSesion = self
        headerView.delegateGoBack = self
        tableResumeActivity.register(UINib(nibName: "CellActivityResumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivityResumeTableViewCell")
        headerView.delegateGoBack = self
        setupButtonn()
       /* let attributeString = NSMutableAttributedString(
                string: "Agregar mas horas en otro proyecto ",
                attributes: buttonAttributes
             )
             btnAddMoreHours.setAttributedTitle(attributeString, for: .normal)*/
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
}
extension ResumeActivityViewController:UITableViewDelegate{
    
}

extension ResumeActivityViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listProjectsName.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heigOfHeader
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
         //asignacion de datos
        headerCell.projectName.text = listProjectsName[section]
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listActivitiesName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableResumeActivity.dequeueReusableCell(withIdentifier: "CellActivityResumeTableViewCell", for: indexPath) as! CellActivityResumeTableViewCell
        cell.labelActivityName.text = listActivitiesName[indexPath.row]
        
        return cell
    }
}

