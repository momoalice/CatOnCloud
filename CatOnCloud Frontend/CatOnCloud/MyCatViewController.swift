//
//  MyCatViewController.swift
//  CatOnCloud
//
//  Created by irene on 10/21/17.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyCatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var preTableView: UITableView!
    
    var posts: [Post] = []
    var cat:Cat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        posts = []
//        loadData()
//        preTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        posts = []
        loadData()
        preTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "mypostcell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyPostCell
        
        let post = posts[indexPath.row]
        
        cell.message.text = post.words
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        cell.dateLabel.text = formatter.string(from: post.time as Date)
        cell.likeLabel.text = "Like \(post.likes)"
        cell.images = post.images
        cell.cellCollectionView.reloadData()
        return cell
    }
    
    func loadData(){
        navigationItem.title = "\(cat.name)'s Posts"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let baseURL = appDelegate.baseURL
        let catID = cat.data["id"].intValue
        Alamofire.request("\(baseURL)/getposts?id=\(catID)").responseJSON { response in
            
            if((response.result.value) != nil) {
                let json = JSON(response.result.value!)
                let helper = ImageHelper()
                for postJson in json {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
                    let date = dateFormatter.date(from: postJson.1["time"].stringValue)
                    let post = Post(id:postJson.1["id"].intValue,time: date as! NSDate, likes: postJson.1["likes"].intValue, words: postJson.1["words"].stringValue)
                    
                    for url in postJson.1["imageURLS"]{
                        ImageHelper().downloadImage(url:"\(baseURL)\(url.1.stringValue)" , completion: { (image) in
                            post.images.append(image!)
                            self.preTableView.reloadData()
                        })
                    }
                    
                    self.posts.append(post)
                    self.preTableView.reloadData()
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue4"{
            let nextScene = segue.destination as? PostViewController
            nextScene?.catID = cat.data["id"].intValue
            nextScene?.prevController = self
        }
    }
    
    
    
    
}
