//
//  EmailSignupVC.swift
//
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit
import FirebaseAuth

final class EmailSignupVC: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rePasswordTextfield: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    
    private var model: EmailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = EmailModel(self)
        self.signupBtn.layer.cornerRadius = 10
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        model?.signup(email: emailTextField.text ?? "",
                          pw: passwordTextField.text ?? "",
                          repw: rePasswordTextfield.text ?? "")
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension EmailSignupVC: PLoginModel {
    func success(type: LoginType) {
        print("이메일 회원가입 성공")
        self.showFirstVC()
    }
    
    func fail(type: LoginType, errorMessage: String) {
        print("이메일 회원가입 실패")
        AlertManager.shared.okAlert(self, title: "회원가입 실패", message: errorMessage)
    }
}
