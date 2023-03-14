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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        emailPasswordField.delegate = self
        self.loginBtn.layer.cornerRadius = 10
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        self.showSignupVC()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case EmailErrorList.WRONG_EMAIL_FORMAT.rawValue:
                    self.setAlert(message: "이메일 형식이 잘못되었습니다.")
                    break
                case EmailErrorList.MISMATCH_PASSWORD.rawValue: // 비밀번호 틀림
                    self.setAlert(message: "비밀번호가 일치하지 않습니다.")
                    break
                case EmailErrorList.NON_EXISTENT_USER.rawValue:
                    self.setAlert(message: "이메일이 존재하지 않습니다.")
                default:
                    print(error.localizedDescription)
                }
                print(error)
            } else {
                self.showMainVC()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    @IBAction func goLogin(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = emailPasswordField.text ?? ""
        
        loginUser(withEmail: email, password: password)
    }
    
    func setAlert(message: String) {
        let alert = UIAlertController(title: "로그인 실패", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}


