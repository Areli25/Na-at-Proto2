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
    var activityHourList: ActivityHourShow?
    var totalHoursProject = 0
    let buttonAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(red: 255.0/255.0, green: 101.0/255.0, blue: 108.0/255.0, alpha: 1.0),
         .underlineStyle: NSUnderlineStyle.single.rawValue
     ]
    var projectName = ""
    var idProject = ""
    var heigOfHeader: CGFloat = 44
    var vcActivityModify: ActivityHourViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityHourList = GlobalParameters.shared.listProjects
        headerView.delegateSesion = self
        headerView.delegateGoBack = self
        tableResumeActivity.register(UINib(nibName: "CellActivityResumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivityResumeTableViewCell")
        headerView.delegateGoBack = self
        setupButtonn()
        underlineButton()
        tableResumeActivity.delegate = self
        tableResumeActivity.dataSource = self
    }
    
    func setupButtonn(){
        btnRegisterHours.applyGradient(colours: [first_gradient,end_gradient])
        btnRegisterHours.layer.cornerRadius = 20;
        btnRegisterHours.layer.masksToBounds = true;
    }
    func underlineButton(){
        let attributeString = NSMutableAttributedString(
                string: "Agregar mas horas en otro proyecto",
                attributes: buttonAttributes
             )
      btnAddMoreHours.setAttributedTitle(attributeString, for: .normal)
    }
    
    func goBack() {
        super.goToBack()
    }
    
    func modifyActivityRecord(index:Int) {
        print(activityHourList?.client.project[getProject(idProject)].activity)
        
        vcActivityModify?.setupActivityRecordList(activityHourList?.client.project[getProject(idProject)].activity)
        vcActivityModify?.tableActivityHour.reloadData()
        super.goToBack()
        
    }
    
    func deleteActivityRecord() {
        
        showModal(section: 0)
    }
    
    func showModal(section:Int){
        
        let baner = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        baner.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        let card = UIView(frame: CGRect(x: 0, y: 0, width: 286, height: 237))
        card.layer.cornerRadius = 10
        
        let imClose = UIImage(named: "cerrar")
        let button = ButtonDeleteProject(frame: CGRect(x: 255, y: 10, width: 20, height: 20))
        button.setImage(imClose, for: .normal)
        button.backgroundColor = .none
        button.addTarget(self, action: #selector(closeDialog(_:)), for: .touchUpInside)
        
        let buttonDelete = ButtonDeleteProject(frame: CGRect(x: 24, y: 162, width: 237, height: 45))
        //buttonDelete.backgroundColor = .gray
        buttonDelete.index = section
        buttonDelete.addTarget(self, action: #selector(self.deleteProject(_:)), for: .touchUpInside)
        buttonDelete.setTitle("Si, eliminar", for: .normal)
        buttonDelete.setTitle("aaaa", for: .selected)
        buttonDelete.setTitleColor(.white, for: .normal)
        buttonDelete.applyGradient(colours: [first_gradient, end_gradient])
        buttonDelete.layer.cornerRadius = 20;
        buttonDelete.layer.masksToBounds = true;
        
        let lbtitle = UILabel(frame: CGRect(x: 22, y: 35, width: 236, height: 40))
        lbtitle.text = "¿Estas seguro de eliminar las horas del proyecto?"
        lbtitle.font = UIFont.init(name: "Europa-Bold", size: 15)
        lbtitle.numberOfLines = 0
        
        let lbContent = UILabel(frame: CGRect(x: 25, y: 83, width: 236, height: 80))
        lbContent.lineBreakMode = .byWordWrapping
        lbContent.textAlignment = .left
        lbContent.numberOfLines = 2
        lbContent.text = " Proyecto: \n \(projectName) "
        lbContent.font = UIFont.init(name: "Nunito-SemiBold", size: 15)
        
        //card content
        card.addSubview(lbContent)
        card.addSubview(lbtitle)
        card.addSubview(button)
        card.addSubview(buttonDelete)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        card.backgroundColor = .white
        
        baner.tag = 100
        baner.addSubview(card)
        view.addSubview(baner)
        
        card.center = baner.convert(baner.center, from:baner.superview)
    }
    
    @objc func closeDialog(_ sender: Any){
        deleteDialog()
    }
    
    @objc func deleteProject(_ sender: Any){
        let index = (sender as! ButtonDeleteProject).index
        print(index)
        deleteDialog()
    }
    
    func deleteDialog(){
        if let myView = self.view.viewWithTag(100){
            myView.willMove(toWindow: nil)
            myView.removeFromSuperview()
        }
    }
}
extension ResumeActivityViewController:UITableViewDelegate{
    
}

extension ResumeActivityViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return activityHourList!.client.project.count
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
        headerCell.projectName.text = activityHourList?.client.project[getProject(idProject)].name
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityHourList!.client.project[getProject(idProject)].activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableResumeActivity.dequeueReusableCell(withIdentifier: "CellActivityResumeTableViewCell", for: indexPath) as! CellActivityResumeTableViewCell
        
        let activity = activityHourList?.client.project[getProject(idProject)].activity[indexPath.row]
        
        cell.labelActivityName.text = activity?.name
        let duration = activity!.duration
        cell.cellIndex = indexPath.row
        if duration == 1{
            cell.labelActivityHours.text = "\(duration) hora"
            
        }else{
            cell.labelActivityHours.text = "\(duration) horas"
        }
        
        return cell
    }
}
class ButtonDeleteProject:UIButton{
    var index:Int = 0
}



