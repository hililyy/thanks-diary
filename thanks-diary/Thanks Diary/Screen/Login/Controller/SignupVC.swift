//
//  SignupVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit
import FirebaseAuth

final class SignupVC: BaseVC {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextfield: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    private var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(self, self)
        setUI()
        setTarget()
    }
    
    private func setUI() {
        self.signupButton.layer.cornerRadius = 10
        self.passwordTextField.isSecureTextEntry = true
        self.rePasswordTextfield.isSecureTextEntry = true
    }
    
    private func setTarget() {
        signupButton.addTarget { [weak self] _ in
            guard let self = self,
                  let email = self.emailTextField.text,
                  let password = self.passwordTextField.text
            else { return }
            
            self.viewModel?.signup(email: email, password: password)
        }
        
        backButton.addTarget { [weak self] _ in
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
