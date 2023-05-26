//
//  LoginViewModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/05/26.
//

import UIKit

final class LoginViewModel {
    
    private var view: PLoginValidity
    private var vc: UIViewController
    
    init(_ view: PLoginValidity, _ vc: UIViewController) {
        self.view = view
        self.vc = vc
    }

    func login(email: String, password: String) {
        FirebaseLoginManager.shared.emailLogin(email: email, pw: password) { message in
            if let message = message {
                self.view.fail(errorMessage: message)
            } else {
                self.view.success()
            }
        }
    }
}
