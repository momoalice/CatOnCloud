//
//  LoginViewController.swift
//  CatOnCloud
//
//  Created by Henry Xing on 21/10/2017.
//  Copyright © 2017 irene. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func login() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let baseURL = (UIApplication.shared.delegate as! AppDelegate).baseURL
        Alamofire.request("\(baseURL)/auth?username=\(username)&password=\(password)").responseJSON { response in
            
            if((response.result.value) != nil) {
                let json = JSON(response.result.value!)
                if (json["status"] == 0) {
                    self.errorLabel.text = "Invalid Credentials"
                } else {
                    self.errorLabel.text = ""
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabController")
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.userID = json["id"].int!
                    appDelegate.window?.rootViewController = tabBarController
                }
            }
        }        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
