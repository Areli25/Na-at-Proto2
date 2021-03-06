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
    @IBOutlet weak var labelHours: UILabel!
    var activityHourList: ActivityHourShow?
    var totalHoursProject = 0
    var requestCreateRecord:Record?
    var responseRecordList:[ResponseRecord] = []
    var listSuccess:[Bool] = []
    let buttonAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor(red: 255.0/255.0, green: 101.0/255.0, blue: 108.0/255.0, alpha: 1.0),
         .underlineStyle: NSUnderlineStyle.single.rawValue
     ]
    var projectName = ""
    var idProject = ""
    var heigOfHeader: CGFloat = 44
    var vcActivityModify: ActivityHourViewController?
    var vcFinalScreen: ActivityViewController?
    var responseCrateActivity:[ResponseRecord] = []
    var contador = 0
    var isRegisterSuccess:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityHourList = GlobalParameters.shared.listProjects
        showButtonAddMoreHours()
        headerView.delegateSesion = self
        headerView.delegateGoBack = self
        tableResumeActivity.register(UINib(nibName: "CellActivityResumeTableViewCell", bundle: nil), forCellReuseIdentifier: "CellActivityResumeTableViewCell")
        headerView.delegateGoBack = self
        setupButtonn()
        labelHours.text = "\(totalHoursProject) hrs"
        underlineButton()
        tableResumeActivity.delegate = self
        tableResumeActivity.dataSource = self
    }
    
    
    func setupButtonn(){
        btnRegisterHours.applyGradient(colours: [first_gradient,end_gradient])
        btnRegisterHours.layer.cornerRadius = 20;
        btnRegisterHours.layer.masksToBounds = true;
    }
    func showButtonAddMoreHours(){
        if GlobalParameters.shared.totalHoursProjects == 8{
            btnAddMoreHours.isHidden = true
        }else{
            btnAddMoreHours .isHidden = false
        }
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
    
    @IBAction func addHoursInProject(_ sender: Any) {
        for vc in self.navigationController!.viewControllers {
            if vc.isKind(of: ProjectsViewController.self) {
                GlobalParameters.shared.isFirstTime = false
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    func registerRecordActivity(){
        let listActivity:[ActivitiesRecord] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateInFormat = dateFormatter.string(from: NSDate() as Date)
        
        for project in GlobalParameters.shared.listProjects!.client.project {
            for _ in project.activity {
               // listActivity.append(ActivitiesRecord(idProject: project.id, id: activity.id!, duration: activity.duration))
                
                Service.shared.createActivityRecord(projectId: project.id, activity: listActivity, date: dateInFormat, completion: { [self]
                    res in
                    switch res {
                    case .success(let encodedData):
                        print(encodedData)
                        
                    case .failure(let err):
                        isRegisterSuccess = false
                        print(err)
                    }
                })
            }
        }
    }
    
    @IBAction func registerHours(_ sender: Any) {
        registerRecordActivity()
        performSegue(withIdentifier: "doRegister", sender: nil)
    }
    
    func modifyActivityRecord(index:Int) {
        var duration = 0
        for activity in GlobalParameters.shared.listProjects!.client.project[index].activity {
            duration += activity.duration
        }
    
        GlobalParameters.shared.totalHoursProjects -= duration
        vcActivityModify?.projectName = activityHourList!.client.project[index].name
        vcActivityModify?.totalHours = duration
        vcActivityModify?.idProject = activityHourList!.client.project[index].id
        vcActivityModify?.setupActivityRecordList(activityHourList?.client.project[index].activity)
        vcActivityModify?.tableActivityHour.reloadData()
        super.goToBack()
  
    }
    
    func deleteActivityRecord(index:Int) {
        showModal(section: index)
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
        buttonDelete.index = section
        buttonDelete.addTarget(self, action: #selector(self.deleteProject(_:)), for: .touchUpInside)
        buttonDelete.setTitle("Si, eliminar", for: .normal)
        buttonDelete.setTitle("aaaa", for: .selected)
        buttonDelete.setTitleColor(.white, for: .normal)
        buttonDelete.applyGradient(colours: [first_gradient, end_gradient])
        buttonDelete.layer.cornerRadius = 20;
        buttonDelete.layer.masksToBounds = true;
        
        let lbtitle = UILabel(frame: CGRect(x: 22, y: 35, width: 236, height: 40))
        lbtitle.text = "??Estas seguro de eliminar las horas del proyecto?"
        lbtitle.font = UIFont.init(name: "Europa-Bold", size: 15)
        lbtitle.numberOfLines = 0
        
        let lbContent = UILabel(frame: CGRect(x: 25, y: 83, width: 236, height: 80))
        lbContent.lineBreakMode = .byWordWrapping
        lbContent.textAlignment = .left
        lbContent.numberOfLines = 2
        lbContent.text = " Proyecto: \n \(activityHourList!.client.project[section].name) "
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
        var hoursInProject = 0
        
        for activity  in GlobalParameters.shared.listProjects!.client.project[index].activity {
            hoursInProject += activity.duration
        }
        
        activityHourList?.client.project.remove(at: index)
        GlobalParameters.shared.listProjects?.client.project.remove(at: index)
        GlobalParameters.shared.totalHoursProjects -= hoursInProject
        totalHoursProject -= hoursInProject
        labelHours.text = "\(totalHoursProject) hrs"
        showButtonAddMoreHours()
        tableResumeActivity.reloadData()
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
        headerCell.projectName.text = activityHourList?.client.project[section].name
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityHourList!.client.project[section].activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableResumeActivity.dequeueReusableCell(withIdentifier: "CellActivityResumeTableViewCell", for: indexPath) as! CellActivityResumeTableViewCell
        
        let activity = activityHourList?.client.project[indexPath.section].activity[indexPath.row]
        
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



