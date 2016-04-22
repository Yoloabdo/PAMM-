//
//  ViewController.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/22/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // savemylife90*


    @IBAction func fbBtnPressed(sender: FBSDKLoginButton) {
        
        let fbLogin = FBSDKLoginManager()
        
        fbLogin.logInWithReadPermissions(["email"], fromViewController: self) { (results, error) in
            if error != nil {
                print("FB login error")
            }else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("successfuly login with fb \(accessToken)")
            }
        }

    }
}

