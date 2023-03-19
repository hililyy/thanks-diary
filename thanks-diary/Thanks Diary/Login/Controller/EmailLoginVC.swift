//
//  EmailLoginVC.swift
//
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit
import FirebaseAuth

class EmailLoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailPasswordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel: EmailViewModel?
    private var alertManager = AlertManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = EmailViewModel(self)
        self.loginBtn.layer.cornerRadius = 10
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        self.showSignupVC()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goLogin(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = emailPasswordField.text ?? ""
        viewModel?.login(email: email, pw: password)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
}

extension EmailLoginVC: PLoginViewModel {
    func success(type: LoginType) {
        self.showMainVC()
    }
    
    func fail(type: LoginType, errorMessage: String) {
        alertManager.setAlert(self, title: "로그인 실패", message: errorMessage)
    }
}
