//
//  FirebaseLoginManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import Firebase
import FirebaseAuth
import FirebaseCore

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    private init() { }
    
    // 건의하기 게시판 데이터 조회
    func getSuggestDatas(completion: @escaping ([SettingSuggestModel]) -> ()) {
        Database.database().reference().child("suggest").observeSingleEvent(of: .value) { snapshot in
            var values: [[String:Any]] = []
            
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let value = snap.value as? [String: Any] else { return }
                values.append(value)
            }
            
            let newDatas = CommonUtilManager.shared.dictionaryToObject(objectType: SettingSuggestModel.self, dictionary: values)
            
            completion(newDatas ?? [])
        }
    }
    
    // 건의하기 게시판 데이터 추가
    func setSuggestData(contents: String) {
        let newData = [
            "uid": CommonUtilManager.shared.getUUID(),
            "contents": contents,
            "status": "progress"
        ]
        
        Database.database().reference().child("suggest").childByAutoId().setValue(newData)
    }
}

// Auth
extension FirebaseManager {
    // 회원가입
    func signup(email: String, pw: String, completion: @escaping (String?) -> ()) {
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
                    completion("회원가입을 실패하였습니다.")
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // 로그인
    func login(email: String, pw: String, completion: @escaping (String?) -> ()) {
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
                    completion("로그인을 실패하였습니다.")
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // 회원탈퇴
    func signout(completion: @escaping (Bool) -> ()) {
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
        return Auth.auth().currentUser?.email ?? "로그인한 이메일이 없습니다."
    }
}
