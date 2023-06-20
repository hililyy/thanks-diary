//
//  LoginViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class LoginViewModel {
    
    func login(email: String, password: String, resultMessage: @escaping (String?) -> ()) {
        FirebaseManager.shared.login(email: email, pw: password) { message in
            if let message = message {
                resultMessage(message)
            } else {
                resultMessage(nil)
            }
        }
    }
    
    func signup(email: String, password: String, resultMessage: @escaping (String?) -> ()) {
        FirebaseManager.shared.signup(email: email, pw: password) { message in
            if let message = message {
                resultMessage(message)
            } else {
                resultMessage(nil)
            }
        }
    }
}
