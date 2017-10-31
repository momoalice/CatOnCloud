//
//  Post.swift
//  CatOnCloud
//
//  Created by Henry Xing on 21/10/2017.
//  Copyright © 2017 irene. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var id:Int = 0
    var time:NSDate
    var likes:Int = 0
    var words:String
    var images: [UIImage] = []
    
    init(id:Int, time: NSDate, likes: Int, words: String) {
        self.id = id
        self.time = time
        self.likes = likes
        self.words = words
    }

    
}
