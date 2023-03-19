//
//  GoogleLogin.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class GoogleLogin: NSObject ,GIDSignInDelegate {
    // TODO: 추후 리팩토링
    var view: PLoginModel
    var vc: UIViewController
    
    init(_ view: PLoginModel, _ vc: UIViewController) {
        self.view = view
        self.vc = vc
    }
    
    func setGoogleLogin() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = vc
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print ("Error Google sign In: \(error.localizedDescription)")
            return
        }
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        
        FirebaseLoginManager.shared.googleLogin(credential: credential, token: authentication.idToken) {
            result in
            if result {
                self.view.success(type: .google)
            } else {
                self.view.fail(type: .google, errorMessage: "로그인을 실패하였습니다.")
            }
        }
    }
    
    func startGoogleLogin() {
        setGoogleLogin()
        GIDSignIn.sharedInstance().signIn()
    }
}
