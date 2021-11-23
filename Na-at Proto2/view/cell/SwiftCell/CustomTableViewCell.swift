//
//  CustomTableViewCell.swift
//  Na-at Proto2
//
//  Created by mpacheco on 09/11/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var ivImageNews: UIImageView!
    @IBOutlet weak var labelTitleNews: UILabel!
    @IBOutlet weak var labelDateNews: UILabel!
    @IBOutlet weak var labelContentNews: UILabel!
    @IBOutlet weak var btnGoDetail: UIButton!
    @IBOutlet weak var tableCell: UIView!
    var delegate:CustomCell!
    var idNews = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func setupView(){
        tableCell.layer.cornerRadius = 4
        tableCell.layer.borderColor = UIColor.init(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        tableCell.layer.shadowColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08).cgColor
        tableCell.layer.borderWidth = 1
    }
    @IBAction func goNewsDetail(_ sender: Any) {
        delegate?.goNewsDetail(id: idNews)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func downloadImage(from url: URL) {
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() { [weak self] in
                    self?.ivImageNews.image = UIImage(data: data)
                }
            }
        }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

protocol CustomCell {
    func goNewsDetail(id:String)
}



