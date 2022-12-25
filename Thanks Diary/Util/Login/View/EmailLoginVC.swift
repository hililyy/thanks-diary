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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        emailPasswordField.delegate = self

    }
    
    @IBAction func goSignUp(_ sender: Any) {
        guard let vc =  storyboard?.instantiateViewController(identifier: "EmailSignUpVC") as? EmailSignUpVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func goFirstVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc =  storyboard.instantiateViewController(identifier: "FirstStartVC") as? FirstStartVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goMainVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
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
                self.goMainVC()
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


