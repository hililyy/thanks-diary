//
//  KakaoLogin.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth
import FirebaseCore

final class KakaoLogin {
    
    private let firebaseManager = FirebaseManager()
    func startKakaoLogin() {
        // 카카오톡 설치된 경우
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    getKakaoUserInfo(oauthToken?.accessToken)
                    self.loginFirebase()
                }
            }
        }
        // 카카오톡 미설치 (웹뷰)
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error)  in
                if let error = error {
                    print(error)
                } else {
                    getKakaoUserInfo(oauthToken?.accessToken)
                    self.loginFirebase()
                }
            }
        }
        
        func getKakaoUserInfo(_ accessToken : String?){
            UserApi.shared.me() {
                user, error in
                if error == nil {
                    let userEmail = String(describing: user?.kakaoAccount?.email)
                    print("userEmail: ",userEmail)
                }
            }
        }
    }
    
    private func loginFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let email = user?.kakaoAccount?.email,
                      let id = user?.id else { return }
                
                self.firebaseManager.kakaoSignup(
                    email: email,
                    pw: String(id))
            }
        }
    }
}
