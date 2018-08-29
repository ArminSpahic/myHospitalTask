//
//  Globals.swift
//  Task
//
//  Created by Armin Spahic on 27/08/2018.
//  Copyright © 2018 Armin Spahic. All rights reserved.
//

import Foundation

class Globals {
    let TWITTER_CONSUMER_KEY = "i6krTK5zD6rAMEumYnrscbTDc"
    let TWITTER_CONSUMER_SECRET = "LHGIcadqh2qTPsgIMAyPllKgJtNzu4xFgxJqnmyC6JBhaaGRqr"
    let CLIENT_ID = "18048ed83fb3545c6620"
    let CLIENT_SECRET = "6bec92eaee38e18a660b22a901ce9b84aaf459af"
    let LOGGED_IN = "isLoggedIn"
    let HEADER = ["Accept": "application/json"]
    let BASE_URL = "https://github.com/login/oauth/authorize"
    let REDIRECT_URI = "myTask://connect/github/callback"
    let GET_TOKEN_URL = "https://github.com/login/oauth/access_token"
}
