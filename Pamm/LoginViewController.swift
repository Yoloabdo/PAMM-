//
//  ViewController.swift
//  Pamm
//
//  Created by Abdulrhman  eaita on 4/22/16.
//  Copyright © 2016 Abdulrhman eaita. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: MaterialTextField!
    @IBOutlet weak var passwordTextField: MaterialTextField!
    
    @IBOutlet weak var fbLoginbtn: FBSDKLoginButton!{
        didSet{
            fbLoginbtn.delegate = self
        }
    }

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
    
    

 
    
    @IBAction func attemptLogin(sender: UIButton) {
        guard let email = emailTextField.text where email != "",
            let pwd = passwordTextField.text where pwd != ""
            else {
                showErrorAlert("Error", msg: "Login failed, empty email/password")
                return
        }
        
        DataService.sharedInstance().REF_BASE.authUser(email, password: pwd) { (error, data) in
            if error != nil {
                if error.code == StatusAccountNoneExist {
                    self.showErrorAlert("Error", msg: "Non existant login, Creating a new account")
                    
                    // if the email is not existing, we create a new account, not very good UX, but as the toturial, could be improved later.
                    
                    DataService.sharedInstance().REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { (error, result) in
                        guard let _ = result else {
                            self.showErrorAlert("Couldn't create user", msg: "\(error)")
                            return
                        }
                        DataService.sharedInstance().REF_BASE.authUser(email, password: pwd, withCompletionBlock: { (error, authData) in
                            guard let data = authData else {
                                self.showErrorAlert("Couldn't Auth user", msg: "\(error)")
                                return
                            }
                            
                            let user = ["provider": data.provider!, "blah": "Email test"]
                            DataService.sharedInstance().createFireBseUser(data.uid, user: user)
                            self.loginNSUserSave(data.uid)
                        })
                    })
                
                }
                self.showErrorAlert("Wrong login info", msg: "Check your password")
            }else {
                self.loginNSUserSave(data.uid)
            }
        }
    }
    
    func loginNSUserSave(uid: String?) {
        NSUserDefaults.standardUserDefaults().setValue(uid, forKey: KEY_UID)
        if uid != nil {
            self.performSegueWithIdentifier(StoryBoard.LOGIN_SEGUE, sender: nil)
        }

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

extension LoginViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        guard let _ = result else {
            print(error)
            return
        }

        guard let accessToken = FBSDKAccessToken.currentAccessToken().tokenString else {
            self.showErrorAlert("Fb access token failed", msg: "\(error)")
            return
        }
        
        // login firebase
        DataService.sharedInstance().REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (error, data) in
            guard let data = data, provider = data.provider else {
                self.showErrorAlert("Fb login failed", msg: "\(error)")
                return
            }
            let user = ["provider": provider, "blah": "test"]
            DataService.sharedInstance().createFireBseUser(data.uid, user: user)
            
            self.loginNSUserSave(data.uid)
        })

    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        loginNSUserSave(nil)
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
//        loginNSUserSave(loginButton)
        return true
    }
}

