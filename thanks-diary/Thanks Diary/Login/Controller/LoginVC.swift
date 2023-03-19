//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {
    @IBOutlet var lottieView: UIView!
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(self, self)
        viewModel?.setLottie(self, lottieView: lottieView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func login(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            viewModel?.login(type: .apple)
        case 1:
            viewModel?.login(type: .kakao)
        case 2:
            viewModel?.login(type: .google)
        case 3:
            self.showEmailLogin()
        case 4:
            viewModel?.login(type: .none)
        default:
            return
        }
    }
}
    
extension LoginVC: PLoginViewModel {
    func success(type: LoginType) {
        LocalDataStore.localDataStore.setOAuthType(newData: type.rawValue)
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
