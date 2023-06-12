//
//  SignupVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit
import FirebaseAuth

final class SignupVC: BaseVC {
    
    private var viewModel: LoginViewModel?
    private let signupView = SignupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(self, self)
        view = signupView
        setTarget()
    }
    
    private func setTarget() {
        signupView.signupButton.addTarget { [weak self] _ in
            guard let self = self,
                  let email = self.signupView.emailTextField.text,
                  let password = self.signupView.passwordTextField.text
            else { return }
            
            self.viewModel?.signup(email: email, password: password)
        }
        
        signupView.backButton.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.back(animated: true)
        }
    }
}

extension SignupVC: PLoginValidity {
    func success() {
        AlertManager.shared.okAlert(self, title: "회원가입 완료", message: "회원가입이 완료되었습니다.")
        self.back(animated: true)
    }
    
    func fail(errorMessage: String) {
        AlertManager.shared.okAlert(self, title: "회원가입 실패", message: errorMessage)
    }
}
