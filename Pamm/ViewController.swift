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
    
    @IBOutlet weak var emailTextField: MaterialTextField!
    @IBOutlet weak var passwordTextField: MaterialTextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(StoryBoard.LOGIN_SEGUE, sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    struct StoryBoard {
        static let LOGIN_SEGUE = "loginSuccess"
    }
    
    

    @IBAction func fbBtnPressed(sender: FBSDKLoginButton) {
        
        let fbLogin = FBSDKLoginManager()
        
        fbLogin.logInWithReadPermissions(["email"], fromViewController: self) { (results, error) in
            if error != nil {
                print("FB login error")
            }else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("successfuly login with fb \(accessToken)")
                
                DataSerice.sharedInstance().REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (error, data) in
                    if error != nil {
                        print("Login Failed \(error)")
                    }else {
                        print("Logged in")
                        self.loginSucced(data.uid)
                    }
                    
                })
            }
        }

    }
    
    @IBAction func attemptLogin(sender: UIButton) {
        guard let email = emailTextField.text where email != "",
            let pwd = passwordTextField.text where pwd != ""
            else {
                showErrorAlert("Error", msg: "Login failed, empty email/password")
                return
        }
        
        DataSerice.sharedInstance().REF_BASE.authUser(email, password: pwd) { (error, data) in
            if error != nil {
                if error.code == StatusAccountNoneExist {
                    self.showErrorAlert("Error", msg: "Non existant login, Creating a new account")
                    DataSerice.sharedInstance().REF_BASE.createUser(email, password: pwd, withCompletionBlock: { (error) in
                        if error != nil {
                            self.showErrorAlert("Couldn't create user", msg: "Error creating a new user with \(email)")
                        }else {
                            self.loginSucced(data.uid)
                        }
                    })
                }
                self.showErrorAlert("Wrong login info", msg: "Check your password")
            }else {
                self.loginSucced(data.uid)
            }
        }
        
        
        
    }
    
    func loginSucced(uid: String) {
        NSUserDefaults.standardUserDefaults().setValue(uid, forKey: KEY_UID)
        self.performSegueWithIdentifier(StoryBoard.LOGIN_SEGUE, sender: nil)

    }
    
    func showErrorAlert(title: String, msg: String) -> Void {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
}

