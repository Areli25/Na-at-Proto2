//
//  NewsDetailViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 11/11/21.
//

import UIKit

class NewsDetailViewController: GenericViewController,HeaderProtocol, TryAgain{
    
    @IBOutlet weak var ivImageNews: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDateNews: UILabel!
    @IBOutlet weak var labeBodyNews: UILabel!
    @IBOutlet weak var headerView: ContentHeaders!
    var newsDetail:NewsDetail?
    var idNewsDetail = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkConnectivity()
        headerView.delegateGoBack = self
        headerView.delegateSesion = self
    }
    func checkConnectivity(){
        /*if NetworkMonitor.shared.isConnected{
            getNewsDetail()
        }else{
            showErrorView("network", self)
        }*/
    }
    func getNewsDetail(){
        self.createSpinnerView()
        Service.shared.getDetailNews(id: idNewsDetail, completion: {[self]
            res in
            switch res {
            case .success(let decodedData):
                print(decodedData)
                
                DispatchQueue.main.async {
                    self.newsDetail = decodedData
                    labelTitle.text = newsDetail?.headline
                    labelDateNews.text = newsDetail?.creationDate
                    labeBodyNews.text = newsDetail?.body
                    ivImageNews.downloaded(from: newsDetail?.image ?? "")
                }
                self.hideActivity()
                
            case .failure(let err):
                self.hideActivity()
                    print("Error en la petición: ", err)
            }
        })
    }
    func goBack() {
        super.goToBack()
    }
    func tryAgain() {
       /* if NetworkMonitor.shared.isConnected{
            getNewsDetail()
       }else{
           showErrorView("network", self)
       }*/
    }
}
