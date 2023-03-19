//
//  FirebaseLoginManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import FirebaseAuth
import FirebaseCore

final class FirebaseLoginManager {
    static let shared = FirebaseLoginManager()
    // MARK: - apple
    func appleLogin(credential: AuthCredential, token: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(with: credential) { (authDataResult, error) in
            if let user = authDataResult?.user {
                print("Success Apple Login", user.uid, user.email ?? "-")
                self.saveUserInfo(token: token, authType: "apple")
                completion(true)
            }
            if error != nil {
                print(error?.localizedDescription ?? "error" as Any)
                completion(false)
            }
        }
    }
    
    // MARK: - google
    func googleLogin(credential: AuthCredential, token: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(with: credential) { _, error in
            if error != nil {
                print(error?.localizedDescription ?? "error" as Any)
                completion(false)
            }
            self.saveUserInfo(token: token, authType: "google")
            completion(true)
        }
    }
    
    // MARK: - kakao
    func kakaoSignup(email: String, pw: String){
        Auth.auth().createUser(withEmail: email,
                               password: pw) { result, error in
            if error != nil {
                self.kakaoLogin(email: email, pw: pw)
            }
            self.saveUserInfo(token: pw, authType: "kakao")
        }
    }
    
    func kakaoLogin(email: String, pw: String) {
        Auth.auth().signIn(withEmail: email,
                           password: pw)
    }
    
    // MARK: - email
    func emailSignup(email: String, pw: String, completion: @escaping (String?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: pw) { _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case EmailErrorList.ALREADY_SIGNUP.rawValue:
                    completion("이미 존재하는 이메일입니다.\n다른 이메일로 변경해 주세요.")
                case EmailErrorList.WRONG_EMAIL_FORMAT.rawValue:
                    completion("이메일 형식이 잘못되었습니다.")
                case EmailErrorList.SHORT_PASSWORD.rawValue:
                    completion("비밀번호를 6자 이상 입력해 주세요.")
                default:
                    print(error.localizedDescription)
                }
            } else {
                self.saveUserInfo(token: pw, authType: "email")
                completion(nil)
            }
        }
    }
    
    func emailLogin(email: String, pw: String, completion: @escaping (String?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: pw) { _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case EmailErrorList.WRONG_EMAIL_FORMAT.rawValue:
                    completion("이메일 형식이 잘못되었습니다.")
                case EmailErrorList.MISMATCH_PASSWORD.rawValue:
                    completion("비밀번호가 일치하지 않습니다.")
                case EmailErrorList.NON_EXISTENT_USER.rawValue:
                    completion("이메일이 존재하지 않습니다.")
                default:
                    print(error.localizedDescription)
                    completion("로그인을 실패하였습니다.")
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func saveUserInfo(token: String, authType: String) {
        LocalDataStore.localDataStore.setOAuthToken(newData: token)
        LocalDataStore.localDataStore.setOAuthType(newData: authType)
    }
}
