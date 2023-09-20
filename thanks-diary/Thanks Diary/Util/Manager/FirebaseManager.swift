//
//  FirebaseLoginManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import Firebase
import FirebaseAuth
import FirebaseCore
import RxSwift

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    private init() { }
    
    // 건의하기 게시판 데이터 조회
    func getSuggestDatas(completion: @escaping (Result<[SettingSuggestModel], Error>) -> Void) {
        Database.database().reference().child("suggest").observeSingleEvent(of: .value) { snapshot in
            var values: [[String: Any]] = []
            
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let value = snap.value as? [String: Any] else { return }
                values.append(value)
            }
            
            if let data = CommonUtilManager.shared.dictionaryToObject(objectType: SettingSuggestModel.self, dictionary: values) {
                completion(.success(data))
            }
        }
    }
    
    func getSuggestDatasRx() -> Observable<[SettingSuggestModel]> {
        return Observable.create { emitter in
            
            self.getSuggestDatas { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let err):
                    emitter.onError(err)
                }
            }
            return Disposables.create()
        }
    }
    
    // 건의하기 게시판 데이터 추가
    func setSuggestData(contents: String) {
        let newData = [
            "uid": CommonUtilManager.shared.getUUID(),
            "contents": contents,
            "status": SuggestType.waiting.rawValue
        ]
        
        Database.database().reference().child("suggest").childByAutoId().setValue(newData)
    }
}

// Auth
extension FirebaseManager {
    // 회원가입
    func signup(email: String, pw: String, completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pw) { _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case EmailErrorList.ALREADY_SIGNUP.rawValue:
                    completion("text_already_signup".localized)
                case EmailErrorList.WRONG_EMAIL_FORMAT.rawValue:
                    completion("text_wrong_email_forget".localized)
                case EmailErrorList.SHORT_PASSWORD.rawValue:
                    completion("text_short_password".localized)
                default:
                    completion("text_fail_signup".localized)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // 로그인
    func login(email: String, pw: String, completion: @escaping (String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pw) { _, error in
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case EmailErrorList.WRONG_EMAIL_FORMAT.rawValue:
                    completion("text_wrong_email_format".localized)
                case EmailErrorList.MISMATCH_PASSWORD.rawValue:
                    completion("text_mismatch_password".localized)
                case EmailErrorList.NON_EXISTENT_USER.rawValue:
                    completion("text_non_existent_user".localized)
                default:
                    completion("text_fail_login".localized)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // 회원탈퇴
    func signout(completion: @escaping (Bool) -> Void) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    // 현재 로그인한 유저 아이디
    func getCurrentUserEmail() -> String {
        return Auth.auth().currentUser?.email ?? "text_non_existent_email".localized
    }
}
