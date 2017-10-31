//
//  Meal.swift
//  CatOnCloud
//
//  Created by irene on 10/21/17.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Cat {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var description: String
    var data: JSON
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, description: String, data: JSON) {
        
        // Initialization should fail if there is no name .
        if name.isEmpty   {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.description = description
        self.data = data
    }
    
}
