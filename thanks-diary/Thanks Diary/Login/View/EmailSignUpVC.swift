//
//  EmailSignUpVC.swift
//  
//
//  Created by 강조은 on 2022/12/25.
//

import UIKit
import FirebaseAuth

class EmailSignUpVC: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var rePasswordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goSignUp(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if checkMatchPassword() {
            Auth.auth().createUser(withEmail: email, password: password) {
                [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    let code = (error as NSError).code
                    switch code {
                    case EmailErrorList.ALREADY_SIGNUP.rawValue:
                        self.setAlert(message: "이미 존재하는 이메일입니다.\n다른 이메일로 변경해 주세요.")
                        break
                    case EmailErrorList.WRONG_EMAIL_FORMAT.rawValue:
                        self.setAlert(message: "이메일 형식이 잘못되었습니다.")
                        break
                    case EmailErrorList.SHORT_PASSWORD.rawValue:
                        self.setAlert(message: "비밀번호를 6자 이상 입력해 주세요.")
                        break
                    default:
                        print(error.localizedDescription)
                    }
                    print(error)
                } else {
                    LocalDataStore.localDataStore.setOAuthToken(newData: password)
                    LocalDataStore.localDataStore.setOAuthType(newData: "Email")
                    self.showFirstVC()
                }
            }
        } else {
            self.setAlert(message: "비밀번호가 일치하지 않습니다.\n비밀번호를 동일하게 입력해주세요.")
        }
    }
    
    func checkMatchPassword() -> Bool {
        return self.passwordTextField.text == self.rePasswordTextfield.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    func setAlert(message: String) {
        let alert = UIAlertController(title: "회원가입 실패", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}
