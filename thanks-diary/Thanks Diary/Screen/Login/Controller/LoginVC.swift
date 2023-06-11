//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit

final class LoginVC: BaseVC {
    
    private let loginView = LoginView()
    private var viewModel: LoginViewModel?
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(self, self)
        setTarget()
    }
    
    private func setTarget() {
        loginView.loginButton.addTarget { [weak self] _ in
            guard let self = self,
                  let email = self.loginView.emailTextField.text,
                  let password = self.loginView.passwordTextField.text
            else { return }

            self.viewModel?.login(email: email, password: password)
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
    
extension LoginVC: PLoginValidity {
    
    func success() {
        if UserDefaultManager.bool(forKey: UserDefaultKey.IS_LOGIN.rawValue) {
            setRootVC(name: "Main", identifier: "MainVC")
        } else {
            UserDefaultManager.set(true, forKey: UserDefaultKey.IS_LOGIN.rawValue)
            pushVC(name: "Start", identifier: "PageVC")
        }
    }
    
    func fail(errorMessage: String) {
        AlertManager.shared.okAlert(self, title: "로그인 실패", message: "로그인을 실패하였습니다.")
    }
}
