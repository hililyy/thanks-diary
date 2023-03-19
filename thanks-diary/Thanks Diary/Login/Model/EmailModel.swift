//
//  EmailModel.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/03/20.
//

import Foundation

class EmailModel {
    private var email = EmailLogin()
    var view: PLoginModel
    
    init(_ view: PLoginModel) {
        self.view = view
    }
    
    func login(email: String, pw: String) {
        self.email.startEmailLogin(email: email, pw: pw) { result in
            if let result = result {
                self.view.fail(type: .email, errorMessage: result)
            } else {
                self.view.success(type: .email)
            }
        }
    }
    
    func signup(email: String, pw: String, repw: String) {
        if pw == repw {
            self.email.startEmailSignup(email: email, pw: pw) { result in
                if let result = result {
                    self.view.fail(type: .email, errorMessage: result)
                } else {
                    self.view.success(type: .email)
                }
            }
        } else {
            self.view.fail(type: .email, errorMessage: "비밀번호가 일치하지 않습니다.\n비밀번호를 동일하게 입력해주세요.")
        }
    }
}
