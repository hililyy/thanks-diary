//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit
import GoogleSignIn

final class LoginVC: UIViewController {
    
    @IBOutlet var lottieView: UIView!
    private var model: LoginModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = LoginModel(self, self)
        model?.setLottie(self, lottieView: lottieView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func login(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            model?.login(type: .apple)
        case 1:
            model?.login(type: .kakao)
        case 2:
            model?.login(type: .google)
        case 3:
            self.showEmailLogin()
        case 4:
            model?.login(type: .none)
        default:
            return
        }
    }
}
    
extension LoginVC: PLoginModel {
    func success(type: LoginType) {
        LocalDataStore.localDataStore.setLoginType(newData: type.rawValue)
        if type == .none {
            self.showFirstVC()
        } else {
            self.showMainVC()
        }
    }
    
    func fail(type: LoginType, errorMessage: String) {
        print("로그인 실패")
    }
}
