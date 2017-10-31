//
//  PostViewController.swift
//  CatOnCloud
//
//  Created by Henry Xing on 22/10/2017.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire

class PostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    
    var catID:Int = 0
    var prevController: MyCatViewController!
    let picker = UIImagePickerController()
    
    var images: [UIImage] = []
    var im_ids: [Int] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor.black.cgColor
        picker.delegate = self
        navigationItem.title = "New Post!"
        uploadButton.addTarget(self, action: #selector(upload), for: .touchUpInside)
        cameraButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let helper = ImageHelper()
        helper.uploadImage(image: chosenImage) { (i) in
            self.images.insert(chosenImage, at: 0)
            self.im_ids.insert(i, at: 0)
            self.collection.reloadData()
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func upload(){
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    func takePhoto(){
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker,animated: true,completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postuploadcell", for: indexPath) as! PostUploadCell
        cell.image.image = images[indexPath.row]
        return cell
    }
    
    func submit(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let baseURL = appDelegate.baseURL
        let parameters: [String: AnyObject] = [
            "cat_id" :catID as AnyObject,
            "words": (message.text ?? "") as AnyObject,
            "media_ids": im_ids as AnyObject
        ]
        Alamofire.request("\(baseURL)/posts/create",method:.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//            self.prevController.posts = []
//            self.prevController.loadData()
            self.navigationController?.popViewController(animated: true)
        }
    }

}
