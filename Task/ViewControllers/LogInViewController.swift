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
import SafariServices
import Alamofire
import SwiftyJSON

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var githubLoginBtn: UIButton! {
        didSet {
            githubLoginBtn.layer.cornerRadius = 5.0
        }
    }
    let viewModel = HomePageViewModel()
    var fbLoginSuccess = false
    let global = Globals()
    var authSession: SFAuthenticationSession?
    var githubTokenURL: URL?
    //var code = ""
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
        } else {
            UserDefaults.standard.set(false, forKey: global.LOGGED_IN)
        }
    }
    
    func addTwitterLoginBtn() {
        // Twitter Login
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session?.authToken != nil) {
                self.saveLoggedState()
                self.skip()
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
    
    //MARK: GETTING GITHUB LOGIN URL AND SIGNING IN WITH GITHUB IN FIREBASE
    func getAuthenticateURL() -> URL {
        
        var urlComponent = URLComponents(string: global.BASE_URL)!
        
        var queryItems =  urlComponent.queryItems ?? []
        
        queryItems.append(URLQueryItem(name: "client_id", value: global.CLIENT_ID))
        queryItems.append(URLQueryItem(name: "redirect_uri", value: global.REDIRECT_URI))
        
        urlComponent.queryItems = queryItems
        print("URL is :\(urlComponent.url!)")
        return urlComponent.url!
        
    }
    func authenticate(with url: URL, completion: @escaping ((_ token: String?, _ error: Error?) -> Void)) {
        
        authSession?.cancel()
        
        authSession = SFAuthenticationSession(url: url, callbackURLScheme: nil, completionHandler: { url, error in
            if error != nil {
                print("Error getting Github token: ", error as Any)
            } else {
                print("The code is :", url!.absoluteString)
                let url = url!.absoluteString
                let code = url.substring(from: url.range(of: "code=")!.upperBound)
                let params : [String : String] = ["client_id" : self.global.CLIENT_ID, "client_secret" : self.global.CLIENT_SECRET, "code" : code]
                self.getGithubToken(url: self.global.GET_TOKEN_URL, parameters: params)
     
            }
       
        })
        
        authSession?.start()
    }
    func getGithubToken(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .post, parameters: parameters,  headers: global.HEADER).responseJSON { (response) in
            if response.result.isSuccess {
                self.saveLoggedState()
                self.skip()
                print("Token is :", response.result.value as Any)
                let jsonResponse: JSON = JSON(response.result.value as Any)
                if let jsonToken = jsonResponse["access_token"].string {
                    let token = jsonToken
                    let credential = GitHubAuthProvider.credential(withToken: token)
                    Auth.auth().signInAndRetrieveData(with: credential, completion: { (authResult, error) in
                        if error != nil {
                            print("Error signing in with Github in Firebase")
                        } else {
                            print("User successfully signed in Firebase through Github account")
                            
                        }
                    })
                }
                
            } else {
                print("Error getting token")
            }
        }
    }
    
    @IBAction func githubLoginBtnPressed(_ sender: UIButton) {
        getAuthenticateURL()
        authenticate(with: getAuthenticateURL()) { (token, error) in
            if error != nil {
                print("Error")
            } else {
                print("Success")
            }
        }
        
        
    }
    
    
    
}
