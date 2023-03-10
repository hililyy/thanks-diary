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

extension LoginVC {
    func startKakaoLogin() {
            //카카오톡 설치된 경우 카톡 실행
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("success")
                        onKakaoLoginCompleted(oauthToken?.accessToken)
                        self.loginInFirebase()
                    }
                }
            }
            //카카오톡 설치되지 않은 경우 카카오 로그인 웹뷰를 띄움
            else{
                UserApi.shared.loginWithKakaoAccount {(oauthToken, error)  in
                    if let error = error {
                        print(error)
                    } else {
                        print("success!")
                        onKakaoLoginCompleted(oauthToken?.accessToken)
                    }
                }
            }
            
        func onKakaoLoginCompleted(_ accessToken : String?){
            getKakaoUserInfo(accessToken)
        }
        
        func getKakaoUserInfo(_ accessToken : String?){
            UserApi.shared.me() { [weak self] user, error in
                if error == nil {
                    let userEmail = String(describing: user?.kakaoAccount?.email)
                    print("userEmail: ",userEmail)
                }
                
            }
        }
    }
    private func loginInFirebase() {

        UserApi.shared.me() { user, error in
            if let error = error {
                print("DEBUG: 카카오톡 사용자 정보가져오기 에러 \(error.localizedDescription)")
            } else {
                print("DEBUG: 카카오톡 사용자 정보가져오기 success.")

                // 파이어베이스 유저 생성 (이메일로 회원가입)
                Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error = error {
                        print("로그인 완료")
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                    } else {
                        guard let id = user?.id else { return }
                        LocalDataStore.localDataStore.setOAuthToken(newData: String(id))
                        LocalDataStore.localDataStore.setOAuthType(newData: "kakao")
                        print("회원가입 완료")
                        
                    }
                    self.goFirstVC()
                }
            }
        }
    }
}
