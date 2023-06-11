//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit

final class LoginVC: BaseVC {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var noneLoginBtn: UIButton!
    
    private var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(self, self)
        setUI()
        setTarget()
    }
    
    private func setUI() {
        emailView.layer.cornerRadius = 20
        emailView.layer.borderColor = Color.COLOR_GRAY3?.cgColor
        emailView.layer.borderWidth = 1
        
        passwordView.layer.cornerRadius = 20
        passwordView.layer.borderColor = Color.COLOR_GRAY3?.cgColor
        passwordView.layer.borderWidth = 1
        
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        loginButton.tintColor = Color.COLOR_GRAY2
        loginButton.setTitleColor(Color.COLOR_GRAY1, for: .normal)
        loginButton.layer.cornerRadius = 20
    }
    
    private func setTarget() {
        loginButton.addTarget { [weak self] _ in
            guard let self = self,
                  let email = self.emailTextField.text,
                  let password = self.passwordTextField.text
            else { return }
            
            self.viewModel?.login(email: email, password: password)
        }
        
        signupBtn.addTarget { [weak self] _ in
            guard let self = self else { return }
            
            self.pushVC(name: "Login", identifier: "SignupVC")
        }
        
        noneLoginBtn.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.pushVC(name: "Start", identifier: "PageVC")
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
