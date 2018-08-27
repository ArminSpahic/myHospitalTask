//
//  LogInViewController.swift
//  Task
//
//  Created by Armin Spahic on 20/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {
    let viewModel = HomePageViewModel()
    var fbLoginSuccess = false
    let global = Globals()
    @IBOutlet var loginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addSkipButton()
        addTwitterLoginBtn()
        addFacebookLoginBtn()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil && fbLoginSuccess == true)
        {
            skip()
        }
    }
    
    func addTwitterLoginBtn() {
        // Twitter Login
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(String(describing: session?.userName))")
                print("userID \(String(describing: session?.userID))")
                print("authToken \(String(describing: session?.authToken))")
                guard let token = session?.authToken else {return}
                guard let secret = session?.authTokenSecret else {return}
                let credentials = TwitterAuthProvider.credential(withToken: token, secret: secret)
                Auth.auth().signInAndRetrieveData(with: credentials, completion: { (user, error) in
                    if let err = error {
                        print("Failed to login to Firebase with Twitter: ", err)
                        return
                    } else {
                        print("Successfully created a Firebase-Twitter user: ", user?.additionalUserInfo as Any)
                    }
                })
                self.saveLoggedState()
                self.skip()
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        })
        logInButton.layer.cornerRadius = logInButton.frame.size.height/2;
        logInButton.center = self.view.center
        logInButton.center.y = self.view.frame.size.height - 150;
        self.view.addSubview(logInButton)
        let margins = loginView.layoutMarginsGuide
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -100).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
    }
    
    func addFacebookLoginBtn() {
        let fbLoginBtn = FBSDKLoginButton()
        fbLoginBtn.readPermissions = ["public_profile","email"]
        fbLoginBtn.delegate = self
        fbLoginBtn.center = self.view.center
        fbLoginBtn.center.y = self.view.frame.size.height - 100
        fbLoginBtn.layer.cornerRadius = fbLoginBtn.frame.size.height/2
        fbLoginBtn.frame = CGRect(x: 50, y: 445, width: 275, height: 50)
        self.view.addSubview(fbLoginBtn)
        let margins = loginView.layoutMarginsGuide
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        fbLoginBtn.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -160).isActive = true
        fbLoginBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        fbLoginBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        if FBSDKAccessToken.current() != nil {
            saveLoggedState()
        } else {
            UserDefaults.standard.set(false, forKey: global.LOGGED_IN)
        }
    }
    
    func addSkipButton() {
        //Skip Button
        let skipButton = UIButton.init(frame: CGRect(x: 0, y: self.view.frame.size.height - 44, width: self.view.frame.size.width, height: 40))
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        skipButton.sendActions(for: .touchUpInside)
        UserDefaults.standard.set(false, forKey: global.LOGGED_IN)
        self.view.addSubview(skipButton)
        let margins = loginView.layoutMarginsGuide
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -20).isActive = true
        skipButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        } else if result.isCancelled {
            print("User cancelled request")
        } else {
            fbLoginSuccess = true
            saveLoggedState()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    @objc func skip(){
        performSegue(withIdentifier: "mainView", sender: self)
    }
    
    func saveLoggedState() {
        let def = UserDefaults.standard
        def.set(true, forKey: global.LOGGED_IN)
        def.synchronize()
       
    }
}
