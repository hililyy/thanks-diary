//
//  LoginVC.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/12/19.
//

import UIKit

final class LoginVC: BaseVC {
    
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
        pushVC(name: "Start", identifier: "PageVC")
    }
    
    func fail(type: LoginType, errorMessage: String) {
        AlertManager.shared.okAlert(self, title: "로그인 실패", message: "로그인을 실패하였습니다.")
    }
}
