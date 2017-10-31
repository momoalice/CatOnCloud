//
//  AdoptController.swift
//  CatOnCloud
//
//  Created by Alice on 10/22/17.
//  Copyright © 2017 irene. All rights reserved.
//



import UIKit
import Alamofire
import SwiftyJSON

class AdoptController: UITableViewController {
    
    ///MARK: Properties
    var cats = [ Cat ]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOwnedCats()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "acell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AdoptCell  else {
            fatalError("The dequeued cell is not an instance of SubCatTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let cat = cats[indexPath.row]
        
        cell.nameLabel.text = cat.name
        cell.photoImageView.image = cat.photo
        cell.nameDescription.text = cat.description
        
        return cell
    }
    
    func loadOwnedCats() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let baseURL = appDelegate.baseURL
        
        Alamofire.request("\(baseURL)/newcats").responseJSON { response in
            
            if((response.result.value) != nil) {
                let json = JSON(response.result.value!)
                let helper = ImageHelper()
                for catJson in json {
                    let url = catJson.1["pics"].arrayValue[0].stringValue
                    helper.downloadImage(url: "\(baseURL)\(url)", completion: { (image) in
                        let cat = Cat(name: catJson.1["name"].stringValue, photo: image, description: catJson.1["description"].stringValue, data: catJson.1)
                        self.cats.append(cat!)
                        self.tableView.reloadData()
                    })
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue9",
            let nextScene = segue.destination as? AdoptNewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedVehicle = cats[indexPath.row]
            nextScene.prevController = self
            nextScene.cat = selectedVehicle
            
            
        }
    }
}

