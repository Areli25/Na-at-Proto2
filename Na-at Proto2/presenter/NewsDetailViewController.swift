//
//  NewsDetailViewController.swift
//  Na-at Proto2
//
//  Created by mpacheco on 11/11/21.
//

import UIKit

class NewsDetailViewController: GenericViewController,HeaderProtocol {
    

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
        headerView.delegateGoBack = self
    }
    func getNewsDetail(){
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
                
            case .failure(let err):
                    print("Error en la petición: ", err)
            }
            
        })
    }
    func goBack() {
        super.goToBack()
    }
}
