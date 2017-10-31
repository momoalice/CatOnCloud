//
//  PostCell.swift
//  CatOnCloud
//
//  Created by Henry Xing on 21/10/2017.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire

class PostCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var likebutton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cellCollectionView: UICollectionView!
    var images : [UIImage] = []
    
    var postID:Int = 0
    var liked:Int = 0
    
    func likepressed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let baseURL = appDelegate.baseURL
        let parameters: [String: Int] = [
            "id" : postID
        ]
        Alamofire.request("\(baseURL)/posts/liked",method:.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            self.likebutton.setTitle("Liked \(self.liked + 1)", for: .normal)
            self.likebutton.isEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postpiccell", for: indexPath) as! PostPicCell
        cell.pic.image = images[indexPath.row]
        return cell
    }
    
    
    
}
