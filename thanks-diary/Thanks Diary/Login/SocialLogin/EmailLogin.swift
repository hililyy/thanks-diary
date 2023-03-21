//
//  EmailLogin.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit

final class EmailLogin {
    
    func startEmailLogin(email: String, pw: String, completion: @escaping  (String?) -> ()) {
        FirebaseLoginManager.shared.emailLogin(email: email, pw: pw) { result in
            completion(result)
        }
    }
    
    func startEmailSignup (email: String, pw: String, completion: @escaping  (String?) -> ()) {
        FirebaseLoginManager.shared.emailSignup(email: email, pw: pw) { result in
            completion(result)
        }
    }
}
