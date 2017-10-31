//
//  MyPostCell.swift
//  CatOnCloud
//
//  Created by Henry Xing on 21/10/2017.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit

import UIKit
import Alamofire

class MyPostCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var cellCollectionView: UICollectionView!
    var images : [UIImage] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mypostpiccell", for: indexPath) as! MyPostPicCell
        cell.pic.image = images[indexPath.row]
        return cell
    }
    
    
    
}
