//
//  AdoptNewController.swift
//  CatOnCloud
//
//  Created by Alice on 10/22/17.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire

class AdoptNewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cat: Cat!
    var images: [UIImage] = []
    var prevController: AdoptController!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descText: UITextView!
    
    @IBOutlet weak var preTableView: UITableView!
    
    @IBOutlet weak var subButton: UIButton!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "bcell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AdoptNewCell
        // Fetches the appropriate meal for the data source layout.
        cell?.cellImageView.image = images[indexPath.row]
        return cell!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCat()
        subButton.addTarget(self, action: #selector(subscribe), for: .touchUpInside)
    }
    
    func subscribe() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let baseURL = appDelegate.baseURL
        let parameters: [String: Int] = [
            "adopter_id" : appDelegate.userID,
            "newcat_id" : cat.data["id"].intValue
        ]
        Alamofire.request("\(baseURL)/newcat/adopted",method:.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            self.prevController.cats = []
            self.prevController.tableView.reloadData()
            self.prevController.loadOwnedCats()
            self.navigationController?.popToViewController(self.prevController, animated: true)
        }
    }
    
    private func loadCat() {
        
        self.nameLabel.text = cat.name
        self.descText.text = cat.description
        for url in cat.data["pics"].arrayValue {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let baseURL = appDelegate.baseURL
            let helper = ImageHelper()
            helper.downloadImage(url: "\(baseURL)\(url.stringValue)") { (image) in
                self.images.append(image!)
                self.preTableView.reloadData()
            }
        }
    }

}
