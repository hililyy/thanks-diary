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

extension LoginVC: GIDSignInDelegate {
    func setGoogleLogin() {
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print ("Error Google sign In: \(error.localizedDescription)")
            return
        }
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) {[weak self] _, _ in
                LocalDataStore.localDataStore.setGoogleLoginToken(newData: authentication.idToken)
                
                self?.goFirstVC()
            }
    }
    func startGoogleLogin() {
        GIDSignIn.sharedInstance().signIn()
    }
}
