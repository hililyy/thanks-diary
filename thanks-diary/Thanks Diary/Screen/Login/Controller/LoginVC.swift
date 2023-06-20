//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit

final class LoginVC: BaseVC {
    
    private let loginView = LoginView()
    private var viewModel = LoginViewModel()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTarget()
    }
    
    private func setTarget() {
        loginView.loginButton.addTarget { [weak self] _ in
            guard let self = self,
                  let email = self.loginView.emailTextField.text,
                  let password = self.loginView.passwordTextField.text
            else { return }
            
            viewModel.login(email: email,
                            password: password) { [weak self] message in
                guard let self = self else { return }
                
                if let message = message {
                    AlertManager.shared.okAlert(self, title: "로그인 실패", message: message)
                } else {
                    self.setRootVC(name: "Main", identifier: "MainVC")
                }
            }
        }

        loginView.findIdButton.addTarget { [weak self] _ in
            guard self != nil else { return }
            print("아이디 찾기 버튼 클릭")
        }
        

        loginView.findPasswordButton.addTarget { [weak self] _ in
            guard self != nil else { return }
            print("비밀번호 찾기 버튼 클릭")
        }
        
        loginView.backButton.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.back(animated: true)
        }
    }
}
