//
//  EmailLogin.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit

class EmailLogin {
    
    private let firebaseManager = FirebaseManager()
    
    func startEmailLogin(email: String, pw: String, completion: @escaping  (String?) -> ()) {
        firebaseManager.emailLogin(email: email, pw: pw) { result in
            completion(result)
        }
    }
    
    func startEmailSignup (email: String, pw: String, completion: @escaping  (String?) -> ()) {
        firebaseManager.emailSignup(email: email, pw: pw) { result in
            completion(result)
        }
    }
}
