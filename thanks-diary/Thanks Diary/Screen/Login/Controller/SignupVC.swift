//
//  SignupVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit
import FirebaseAuth

final class SignupVC: BaseVC {
    
    private var viewModel = LoginViewModel()
    private let signupView = SignupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signupView
        setTarget()
    }
    
    private func setTarget() {
        
        signupView.signupButton.addTarget { [weak self] _ in
            guard let self = self,
                  let email = self.signupView.emailTextField.text,
                  let password = self.signupView.passwordTextField.text
            else { return }
            
            viewModel.signup(email: email,
                             password: password) { [weak self] message in
                guard let self = self else { return }
                
                if let message = message {
                    AlertManager.shared.okAlert(self, title: "회원가입 실패", message: message)
                } else {
                    self.setRootVC(name: "Login", identifier: "StartVC")
                }
            }
        }
        
        signupView.backButton.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.back(animated: true)
        }
    }
}
