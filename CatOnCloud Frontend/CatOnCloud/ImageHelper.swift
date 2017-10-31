//
//  ImageHelper.swift
//  CatOnCloud
//
//  Created by Henry Xing on 21/10/2017.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ImageHelper: NSObject {
    func downloadImage(url:String, completion: @escaping (_ image: UIImage?) -> Void) {
        let remoteImageURL = URL(string: url)!
        Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                if let data = response.data {
                    completion(UIImage(data: data))
                }
            }
        }
    }
    
    func uploadImage(image:UIImage, name:String="", description:String="", completion: @escaping (_ id:Int) -> Void) {
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        let imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let payload = "data:image/png;base64,\(imageStr)"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let baseURL = appDelegate.baseURL
        let parameters: [String: AnyObject] = [
            "name" : name as AnyObject,
            "description" : description as AnyObject,
            "media_type": 0 as AnyObject,
            "media": payload as AnyObject
        ]
        Alamofire.request("\(baseURL)/media/upload",method:.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if((response.result.value) != nil) {
                let json = JSON(response.result.value!)
                completion(json["id"].intValue)
            }
        }
    }
}
